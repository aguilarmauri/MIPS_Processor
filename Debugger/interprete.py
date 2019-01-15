import json

data = ""

nroStep = 1

# data = "00000000000000000000000000000000000000000000000000000000000011110000000000000000000000000000001000000000000000000000000000000011000000000000000000000000000001000000000000000000000000000000010100000000000000000000000000000110000000000000000000000000000001110000000000000000000000000000100000000000000000000000000000001001000000000000000000000000000010100000000000000000000000000000101100000000000000000000000000001100000000000000000000000000000011010000000000000000000000000000111000000000000000000000000000001111000000000000000000000000000100000000000000000000000000000001000100000000000000000000000000010010000000000000000000000000000100110000000000000000000000000001010000000000000000000000000000010101000000000000000000000000000101100000000000000000000000000001011100000000000000000000000000011000000000000000000000000000000110010000000000000000000000000001101000000000000000000000000000011011000000000000000000000000000111000000000000000000000000000001110100000000000000000000000000011110000000000000000000000000000111110000000000000000000000000000011011111100000000000000000000000000000000000000000000000000000001101111110000000000000000000000000000000000000000000000000000000000000000000011111100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000111111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000010000000000000000000000000000000000000000000101000000000000000000000000000010100000000000000000000000000001000100000000000000000000000000100010000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000010100001010000000000000000000001000100010110000000000000000000100000010110000000000000000000010000001001101000000000000000001000000011011100000000000000000100000001110111100000000000000010000000000000000000000000000001000000000000000000000000000000100000000000000000000000000000010000000000000000000000000000001000000000000000000000000000000100000000000000000000000000000010000000000000000000000000000001000000000000000000000000000000100000000000000000000000000000010000000000000000000000000000001000000000000000000000000000000100000000000000000000000000000010000000000000000000000000000001000000000000000000000000000000100000000000000000000000000000010000000000000000000000000000000"
#

pos = 0
def getDatos(nRegs, nBits):
    global pos
    global data
    if nRegs == 1:
        reg = data[pos : pos + nBits]
        pos = pos + nBits
        return reg
    else:
        array = []
        for i in range(nRegs):
            array.append( data[pos + i*nBits : pos + i*nBits+nBits] )
        pos = pos + i*nBits+nBits
        return array;


# Lista de ejecuciones
execution = []

# Info de la ejecucion actual
info = None

def resetInfo():
    global info
    info = {
                "clocks":   -1,
                "if":       {},
                "ifid":     {},
                "id":       {},
                "idex":     {},
                "ex":       {},
                "exmem":    {},
                "mem":      {},
                "memwb":    {},
                "wb":       {}
    }

execution.append( "" )
def readData(datos):
    global data
    data = datos
    global nroStep
    global pos
    pos = 0
    # global info
    info = {
                "clocks":   -1,
                "if":       {},
                "ifid":     {},
                "id":       {},
                "idex":     {},
                "ex":       {},
                "exmem":    {},
                "mem":      {},
                "memwb":    {},
                "wb":       {}
    }

    # id
    info["id"]["regs"] = getDatos(32,32) # Obtener 32 registros de 32 bits cada uno
    # if
    info["if"]["out_if_add"] = getDatos(1,32)
    info["if"]["out_instruction"] = getDatos(1,32)
    # ifid
    info["ifid"]["out_ifid_add"] = getDatos(1,32)
    info["ifid"]["out_ifid_instruction"] = getDatos(1,32)
    # id
    info["id"]["pc_branch"] = getDatos(1,32)
    # memwb
    info["memwb"]["out_memwb_write_register"] = getDatos(1,8)
    # id
    info["id"]["out_opcode"] = getDatos(1,8)
    info["id"]["out_id_registerRs"] = getDatos(1,8)
    info["id"]["out_id_registertRt"] = getDatos(1,8)
    info["id"]["out_id_registerRd"] = getDatos(1,8)
    info["id"]["out_read_data_1"] = getDatos(1,32)
    info["id"]["out_read_data_2"] = getDatos(1,32)
    info["id"]["out_id_sign"] = getDatos(1,32)
    # idex
    info["idex"]["out_idex_read_data_1"] = getDatos(1,32)
    info["idex"]["out_idex_read_data_2"] = getDatos(1,32)
    info["idex"]["out_idex_sign"] = getDatos(1,32)
    info["idex"]["out_idex_opcode"] = getDatos(1,8)
    info["idex"]["out_idex_registerRs"] = getDatos(1,8)
    info["idex"]["out_idex_registerRt"] = getDatos(1,8)
    info["idex"]["out_idex_registerRd"] = getDatos(1,8)
    # ex
    info["ex"]["out_alu_result"] = getDatos(1,32)
    info["ex"]["out_ex_read_data_2"] = getDatos(1,32)
    info["ex"]["out_ex_write_register"] = getDatos(1,8)
    # exmem
    info["exmem"]["out_exmem_alu_result"] = getDatos(1,32)
    info["exmem"]["in_exmem_read_data2"] = getDatos(1,32)
    info["exmem"]["out_exmem_write_register"] = getDatos(1,8)
    # mem
    info["mem"]["out_mem_alu_result"] = getDatos(1,32)
    info["mem"]["out_read_data"] = getDatos(1,32)
    info["mem"]["out_mem_write_register"] = getDatos(1,8)
    # memwb
    info["memwb"]["out_memwb_read_data"] = getDatos(1,32)
    info["memwb"]["out_memwb_alu_result"] = getDatos(1,32)
    # wb
    info["wb"]["out_wb_mux"] = getDatos(1,32)
    # general
    info["clocks"] = getDatos(1,8)
    # mem
    info["mem"]["memoria_ram"] = getDatos(32,32)
    # instructions
    info["if"]["instructions"] = getDatos(16,32)
    # pc
    info["if"]["pc"] = getDatos(1,32)
    #TAKEN
    info["ex"]["taken"] = getDatos(1,8)
    # Entrada A ALU y Branch
    info["ex"]["inA_Alu_Branch"] = getDatos(1,32)
    # Entrada B Branch
    info["ex"]["inB_Branch"] = getDatos(1,32)
    # Entrada B ALU
    info["ex"]["inB_Alu"] = getDatos(1,32)
    # Agregar ejecucion actual a la lista de ejecuciones
    execution.append( info )

    # Escribir resultados
    f = open("step"+str(nroStep)+".json","w")
    print ("Se creo el archivo step"+str(nroStep)+".json")
    f.write(str(execution[nroStep]).replace('\'', '\"'))
    f.close()
    nroStep += 1
