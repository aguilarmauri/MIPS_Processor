#!/usr/bin/python3

# NOTAS para linux:
# 		Ejecutar con sudo
#		Ver puerto con dmesg | grep ttyUSB
#		Permisos: sudo chmod +x com_serial.py interprete.py
#		Abrir vivado: sudo /opt/Xilinx/Vivado/2017.4/bin/vivado

import serial
import time
from interprete import *
from bitarray import bitarray
import os

xilinx = serial.Serial(
	# port='/dev/ttyUSB1',
	port='COM9',
	baudrate= 19200,
	timeout = 3.0#,
	# parity=serial.PARITY_NONE,
	# stopbits=serial.STOPBITS_ONE,
	# bytesize=serial.EIGHTBITS,
	# xonxoff=0
	)

recibido = ''
p = ["","","","","","","",""]
cantSolicitudes = 0
def main():
	global cantSolicitudes
	global programa
	print ("\tTPF ARQUITECTURA DE COMPUTADORAS")
	print ("\t___ Debugger de placa Xilinx ___")
	print ("\nOpciones del Debugger:")
	print ("--------------------")
	print ("1) Enviar instrucciones")
	print ("2) Recibir paso a paso")
	print ("3) Recibir ultimo paso")

	try:
		while True:
			opcion = input("\n> Introduzca una opcion: ")

			if opcion == "1":
				borrarResultados()
				nroPrograma = int(input("\n> Nro un programa (1 al "+str(len(p)-1)+"): "))
				cargar_programa(nroPrograma)
				# enviarByteAByte("00")
				enviarBitABit("00")
				time.sleep(1)

			if opcion == "2":
				# if cantSolicitudes < int(len(programa)/32)+3:
					# enviarByteAByte("01")
				xilinx.write(bytes("2","utf-8"))
				time.sleep(1)
				recibir()
				# time.sleep(5)
				#cantSolicitudes += 1
				# else:
					# print ("> El programa terminó.")

			if opcion == "3":
				# enviarByteAByte("10")
				xilinx.write(bytes("3","utf-8"))
				time.sleep(1)
				recibir()
				# time.sleep(5)
	except KeyboardInterrupt as e:
		print ("Saliendo del programa.")
	xilinx.close()

def cargar_programa(nroPrograma):
	global programa
	global p


	# Programa 1 - Usa un registro de una operacion que todavía no escribió el dato
	p[1] =  "000000_00001_00010_00001_00000_100001"  		#ADDU $1,$1,$2
	p[1] += "000000_00100_00001_00011_00000_100011"			#SUBU $3,$4,$1
	p[1] += "000000_00001_00011_00001_00000_100001"   		#ADDU $1,$1,$3
	p[1] += "111111_00000_00000_00000_00000_000000"   		#HLT

	#Programa 2 - Guarda siempre en el mismo lugar
	p[2] = "000000_00001_00010_00001_00000_100001"			#ADDU $1,$1,$2
	p[2] += "000000_00001_00011_00001_00000_100001"			#ADDU $1,$1,$3
	p[2] += "000000_00001_00100_00001_00000_100001"			#ADDU $1,$1,$4
	p[2] += "000000_00001_00101_00001_00000_100001"			#ADDU $1,$1,$5
	p[2] += "111111_00000_00000_00000_00000_000000"   		#HLT

	#Programa 3 - Pagina 297 - Hazard del Load que inserta 1 burbuja
	p[3] =  "100011_00100_01010_0000000000000001"    		#LW $10, 1($4)
	p[3] += "000000_00011_00010_01011_00000_100011"  		#SUBU $11, $3, $2
	p[3] += "000000_00011_00100_01100_00000_100001"  		#ADDU $12, $3, $4
	p[3] += "100011_00101_01101_0000000000000001"    		#LW $13, 1($5)
	p[3] += "000000_00101_00110_01110_00000_100001"  		#ADD $14, $5, $6
	p[3] += "111111_00000_00000_00000_00000_000000"   		#HLT

	#Programa 4 - Pagina 304 - Usa un registro que todavia no se escribió en
	# las instrucciones anteriores, tomando el mas reciente
	p[4] =  "000000_00101_00001_00010_00000_100011"  		#SUB $2,$5,$1
	p[4] += "000000_00010_00101_01100_00000_100100"  		#AND $12,$2,$5
	p[4] += "000000_00110_00010_01101_00000_100101"  		#OR $13,$6,$2
	p[4] += "000000_00010_00010_01110_00000_100001"  		#ADD $14,$2,$2
	p[4] += "101011_00010_00010_0000000000001010"    		#SW $2,10($2)
	p[4] += "111111_00000_00000_00000_00000_000000"   		#HLT

	#Programa 5 - Usa BEQ, SLT, LW
	p[5] = "000000_01000_00100_01010_00000_100011"           # SUBU $10, $8, $4
	p[5] += "000100_00001_00001_0000000000000100"            # BEQ  $1,  $1, 4        1 + 4 + 1 = 6
	p[5] += "000000_00010_00101_01100_00000_100100"          # AND  $12, $2, $5
	p[5] += "000000_00010_00110_01101_00000_100101"          # OR   $13, $2, $6
	p[5] += "000000_00100_00010_01110_00000_100001"          # ADDU $14, $4, $2
	p[5] += "000000_00110_00111_01111_00000_101010"          # SLT  $15, $6, $7
	p[5] += "100011_00111_00100_0000000000000001"            # LW   $4,  1($7)
	p[5] += "111111_00000_00000_00000_00000_000000"     	 # HLT

	#Programa 6 - Usa instrucciones type-J
	p[6] = "000000_00011_00100_00101_00000_100001"        # ADDU $5,$3,$4
	p[6] += "000000_00101_00000_00000_00000_001000"		  # JR $5
	p[6] += "100011_00101_00110_0000000000000010"         # LW $6,2($5)
	p[6] += "101011_00001_00010_0000000000000111"         # SW $2, 7($1)
	p[6] += "001000_00011_00101_0000000000001000"         # ADDI $5,$3,8
	p[6] += "101011_00010_01001_0000000000000110"         # SW $9, 6($2)
	p[6] += "100011_00111_01110_0000000000000011"         # LW $14,3($7)
	p[6] += "001101_00011_00111_0000000000010101"         # ORI $7,$3,21
	p[6] += "111111_00000_00000_00000_00000_000000"    	  # HLT

	#Programa 7 - Loop con BNE
	p[7] = "100011_00101_00010_0000000000000100"	      # LW $2,4($5)
	p[7] += "001000_00010_00010_0000000000000001"         # ADDI $2,$2,1
	p[7] += "000101_00010_01100_1111111111111110"         # BNE $2,$12,-2
	p[7] += "000010_00000000000000000000000110"			  # J 6
	p[7] += "001101_00011_00111_0000000000010101"         # ORI $7,$3,21
	p[7] += "000000_00011_00100_00101_00000_100001"       # ADDU $5,$3,$4
	p[7] += "101011_00001_00010_0000000000000000"         # SW $2, 0($1)
	p[7] += "111111_00000_00000_00000_00000_000000"    	  # HLT

	#TODAS LAS INSTRUCCIONES
    #  Register - opcode_rs_rt_rd_shamt_func
    # "000000_00000_00100_00010_00001_000000"        //SLL $2,$4,1
    # "000000_00000_00100_00110_00001_000011"        //SRL $6,$4,1
    # "000000_00000_00100_00110_00001_000010"        //SRA $6,$4,1
    # "000000_00001_00011_00100_00000_000100"        //SLLV $4,$1,$3 -> deberia dar 8
    # "000000_00110_00010_00101_00000_000110"        //SRLV $5,$6,$2 -> deberia dar 1
    # "000000_01011_00001_01010_00000_000111"        //SRAV $10,$11,$1 -> deberia dar 5
    # "000000_00001_00011_00101_00000_100110"      	 //XOR R5, R1, R3
    # "000000_00011_00100_00101_00000_100001"        //ADDU $5,$3,$4
    # "000000_00100_00011_00101_00000_100011"        //SUBU $5,$4,$3
    # "000000_00101_00011_00100_00000_100100"        //AND $4,$5,$3
    # "000000_00101_00011_00100_00000_100101"        //OR $4,$5,$3
    # "000000_00101_00011_00100_00000_100111"        //NOR $4,$5,$3
    # "000000_00001_00010_00011_00000_101010"        //SLT $3,$1,$2
    #  Load
    # "100011_00000_00011_0000000000000010"          //LW $3,0(2)
    #  Store
    # "101011_00000_00101_0000000000000111"          //SW 0(7),$5
    #  Inmediate
    # "001000_00011_00110_0000000000001000"          //ADDI $6,$3,8
    # "001100_00011_00110_0000000000000101"          //ANDI $7,$3,5
    # "001101_00011_00110_0000000000010101"          //ORI $7,$3,21
    # "001111_00000_00010_0000000000001010"          //LUI R2,10
    #  Branch
    # "000100_00001_00010_0000000000000010"          //BEQ $1,$2,2
    # "000101_00001_00010_0000000000000010"          //BNE $1,$2,2 //modificar los valores de los regs para TAKEN
    #  Jump
    # "000000_01010_00000_00000_00000_001000"        //JR
    # "000000_01010_00000_01011_00000_001001"        //JALR

	if nroPrograma < 1 or nroPrograma > len(p):
		nroPrograma = 1

	programa = p[nroPrograma].replace("_","")
	# print ("Programa:",programa)
	print ("Programa de ",int(len(programa)/32)," instrucciones.")


def enviarByteAByte(opcion):
	global programa
	print ("\nEnviando conjunto de instrucciones...")
	bits = bitarray(endian="big")

	# Agregar el codigo del <opcion> al array de bits a enviar
	byte_de_codigo = "111111"+opcion
	for i in byte_de_codigo:
		bits.append(int(i))

	# Agregar el codigo del <programa> al array de bits a enviar
	for i in programa:
		bits.append(int(i))

	print ("Enviado:",bits.to01())
	xilinx.write(bits.tobytes())
	time.sleep(1)
	print ("Instrucciones enviadas.")


def enviarBitABit(opcion):
	global programa
	print ("\nEnviando conjunto de instrucciones...")
	bits = bitarray(endian="big")

	# Agregar el codigo del <opcion> al array de bits a enviar
	#byte_de_codigo = "111111"+opcion		#Estaba descomentada
	# for i in byte_de_codigo:
	# 	xilinx.write(bytes("1","utf-8"))
	xilinx.write(bytes("1","utf-8"))
		#time.sleep(0.1)

	# Agregar el codigo del <programa> al array de bits a enviar
	for i in range(len(programa)):
		#print (i)
		dato = programa[i]
		# print (bytes(str(dato),"utf-8"))
		xilinx.write(bytes(str(dato),"utf-8"))
		xilinx.flush()
		time.sleep(0.01)

	# print ("Enviado:",bits.to01())
	print ("Instrucciones enviadas.")

def recibir():
	print ("\nRecibiendo conjunto de datos...")
	global recibido
	if xilinx.in_waiting > 0:
		recibido = xilinx.read(430)
		bits = bitarray(endian="big")
		bits.frombytes(recibido)
		datos = str(bits.to01())
		print ("Datos recibidos.")
		# print ("Datos recibidos: ",datos)
		# resetInfo()
		readData(datos)
	else:
		print ("No hay datos para recibir.")
	recibido = ''

def borrarResultados():
	for i in range(50):
		try:
			os.remove("step"+str(i)+".json")
		except Exception as e:
			pass


main()
