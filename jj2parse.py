#!/usr/local/bin/python3

#  Parser of the SAVEGAME file in Jazz-Jackrabbit 2
#  Saturday, Jul/04/2020
#  Author: https://github.com/0xbigshaq

import sys
import zlib
from struct import unpack

## utils

def emulate_loop(content, cursor, size):
    counter = 0
    total = ( (0x4 + 0x7c) * (size - 1) )

    while counter < total:
        x = unpack('I', content[cursor : ( cursor + 4  )])[0]
        if(x != 0x00): # if null, skip
            cursor += 0x7c
        cursor += 4 # adjust the cursor
        counter += (0x04 + 0x7c) # always +0x80 
    
    return cursor


def hexdump(raw):
    dump = ''
    for i in raw:
        dump += "{:02X} ".format(i)  
    return dump


def writefile(file_path, content):
    with open(file_path, "wb") as fh:
        for singlebyte in content:
            fh.write(bytes([singlebyte]))


def open_jazzfile(file_path):
    try:
        with open(file_path, "rb") as fh:
            return fh.read()
        
    except FileNotFoundError as err:
        print(err)



def parse_jazzfile(content):
    try:
        # init vars
        cursor = 4
        cursor_prev = 0
        output = ''
        retval = { }
        tmp_chunk = b''

        # start parsing
        if(content[0:4] != b'\x32\x33\x20\x20'): # "magic bytes"
            raise Exception("invalid SAVEGAME file")
        
        output += "\n[ 0x0 - 0x3 ] File's signature ok ( '20  ' )" 

        # chunk 1
        cursor_prev = cursor
        cursor += 4
        size_prefix = unpack('I', content[cursor_prev : (cursor)])[0]
        output += "\n\n[ {0} - {1} ] Size prefix of chunk02: {2}".format(hex(cursor_prev), hex(cursor-1)  , hex(size_prefix))
        retval["chunk01"] = hex(size_prefix)

        
        # chunk 2
        cursor_prev = cursor
        cursor += size_prefix

        tmp_chunk = zlib.decompress(content[cursor_prev : cursor])
        output += "\n[ {0} - {1} ] Decompressing chunk02: \n{2}".format(hex(cursor_prev), hex(cursor-1), hexdump(tmp_chunk))
        retval["chunk02"] = tmp_chunk

        writefile("./outdir/out02.bin", tmp_chunk)


        # chunk 3
        cursor_prev = cursor 
        cursor += 0x20

        tmp_chunk = content[cursor_prev : cursor]
        output += "\n[ {0} - {1} ] Save name: {2}".format(hex(cursor_prev), hex(cursor-1), tmp_chunk)
        retval["chunk03"] = tmp_chunk

        # chunk 4
        cursor_prev = cursor 
        cursor += 0x20

        tmp_chunk = content[cursor_prev : cursor]
        output += "\n[ {0} - {1} ] Map file: {2}".format(hex(cursor_prev), hex(cursor-1), tmp_chunk)
        retval["chunk04"] = tmp_chunk


        # chunk 5
        cursor_prev = cursor 
        cursor += 0x20

        tmp_chunk = content[cursor_prev : cursor]
        output += "\n[ {0} - {1} ] Map name(in GUI): {2}".format(hex(cursor_prev), hex(cursor-1), tmp_chunk)
        retval["chunk05"] = tmp_chunk


        # chunk 6
        cursor_prev = cursor
        cursor += 4

        tmp_chunk = unpack('I', content[cursor_prev : (cursor)])[0]
        output += "\n[ {0} - {1} ] Value(4 bytes): {2}".format(hex(cursor_prev), hex(cursor-1)  , hex(tmp_chunk))
        retval["chunk06"] = hex(tmp_chunk)


        # chunk 7
        cursor_prev = cursor
        cursor += 4

        tmp_chunk = unpack('I', content[cursor_prev : (cursor)])[0]
        output += "\n[ {0} - {1} ] Value(4 bytes): {2}".format(hex(cursor_prev), hex(cursor-1)  , hex(tmp_chunk))
        retval["chunk07"] = hex(tmp_chunk)

        # chunk 8
        cursor_prev = cursor
        cursor += 4
        
        tmp_chunk = unpack('I', content[cursor_prev : (cursor)])[0]
        output += "\n[ {0} - {1} ] Value(4 bytes): {2}".format(hex(cursor_prev), hex(cursor-1)  , hex(tmp_chunk))
        retval["chunk08"] = hex(tmp_chunk)


        # chunk 9
        cursor_prev = cursor
        cursor += 4
        
        tmp_chunk = unpack('I', content[cursor_prev : (cursor)])[0]
        output += "\n[ {0} - {1} ] Value(4 bytes): {2}".format(hex(cursor_prev), hex(cursor-1)  , hex(tmp_chunk))
        retval["chunk09"] = hex(tmp_chunk)


        # chunk 10
        cursor_prev = cursor
        cursor += 4
        
        tmp_chunk = unpack('I', content[cursor_prev : (cursor)])[0]
        output += "\n[ {0} - {1} ] Value(4 bytes): {2}".format(hex(cursor_prev), hex(cursor-1)  , hex(tmp_chunk))
        retval["chunk10"] = hex(tmp_chunk)
        

        # chunk 11
        cursor_prev = cursor
        cursor += 0x40
        
        tmp_chunk = content[cursor_prev : cursor]
        output += "\n[ {0} - {1} ] Null padding(0x40 bytes): {2}".format(hex(cursor_prev), hex(cursor-1)  , tmp_chunk)
        retval["chunk11"] = tmp_chunk


        # chunk 12
        cursor_prev = cursor
        cursor += 4
        
        tmp_chunk = unpack('I', content[cursor_prev : (cursor)])[0]
        output += "\n[ {0} - {1} ] Size prefix of chunk13: {2}".format(hex(cursor_prev), hex(cursor-1)  , hex(tmp_chunk))
        retval["chunk12"] = hex(tmp_chunk)


        # chunk 13
        cursor_prev = cursor
        cursor += tmp_chunk

        tmp_chunk = zlib.decompress(content[cursor_prev : cursor])
        output += "\n[ {0} - {1} ] Decompressing chunk13: \n{2}".format(hex(cursor_prev), hex(cursor-1), hexdump(tmp_chunk))
        retval["chunk13"] = tmp_chunk

        writefile("./outdir/out13.bin", tmp_chunk)


        # chunk 14
        cursor_prev = cursor
        cursor += 4
        
        tmp_chunk = unpack('I', content[cursor_prev : (cursor)])[0]
        output += "\n\n[ {0} - {1} ] Size prefix of chunk15: {2}".format(hex(cursor_prev), hex(cursor-1)  , hex(tmp_chunk))
        retval["chunk14"] = hex(tmp_chunk)


        # chunk 15
        cursor_prev = cursor
        cursor += tmp_chunk

        tmp_chunk = zlib.decompress(content[cursor_prev : cursor])
        output += "\n[ {0} - {1} ] Decompressing chunk15: \n{2}".format(hex(cursor_prev), hex(cursor-1), hexdump(tmp_chunk))
        retval["chunk15"] = tmp_chunk

        writefile("./outdir/out15.bin", tmp_chunk)


        # chunk 16
        cursor_prev = cursor
        cursor += 4
        
        tmp_chunk = unpack('I', content[cursor_prev : (cursor)])[0]
        output += "\n[ {0} - {1} ] Number of elements(of object below): {2}".format(hex(cursor_prev), hex(cursor-1)  , hex(tmp_chunk))
        retval["chunk16"] = hex(tmp_chunk)


        # chunk 17, originally written using a loop
        cursor_prev = cursor
        cursor = emulate_loop(content, cursor, tmp_chunk)

        tmp_chunk = content[cursor_prev : cursor]
        output += "\n[ {0} - {1} ] Dynamic Chunk / Hash table(raw): \n{2}".format(hex(cursor_prev), hex(cursor-1), hexdump(tmp_chunk))
        retval["chunk17"] = tmp_chunk 

        writefile("./outdir/out17.raw", tmp_chunk)



        # chunk 18
        cursor_prev = cursor
        cursor += 4
        
        tmp_chunk = unpack('I', content[cursor_prev : (cursor)])[0]
        output += "\n\n[ {0} - {1} ] Size prefix of chunk19: {2}".format(hex(cursor_prev), hex(cursor-1)  , hex(tmp_chunk))
        retval["chunk18"] = hex(tmp_chunk)


        # chunk 19
        cursor_prev = cursor
        cursor += tmp_chunk

        tmp_chunk = zlib.decompress(content[cursor_prev : cursor])
        output += "\n[ {0} - {1} ] Decompressing chunk19: \n{2}".format(hex(cursor_prev), hex(cursor-1), hexdump(tmp_chunk))
        retval["chunk19"] = tmp_chunk

        writefile("./outdir/out19.bin", tmp_chunk)


        # chunk 20
        cursor_prev = cursor
        cursor += 4
        
        tmp_chunk = unpack('I', content[cursor_prev : (cursor)])[0]
        output += "\n\n[ {0} - {1} ] Size prefix of chunk21: {2}".format(hex(cursor_prev), hex(cursor-1)  , hex(tmp_chunk))
        retval["chunk20"] = hex(tmp_chunk)


        # chunk 21
        cursor_prev = cursor
        cursor += tmp_chunk

        tmp_chunk = zlib.decompress(content[cursor_prev : cursor])
        output += "\n[ {0} - {1} ] Decompressing chunk21: \n{2}".format(hex(cursor_prev), hex(cursor-1), hexdump(tmp_chunk))
        retval["chunk21"] = tmp_chunk

        writefile("./outdir/out21.bin", tmp_chunk)


        # chunk 22
        cursor_prev = cursor
        cursor += 4
        
        tmp_chunk = unpack('I', content[cursor_prev : (cursor)])[0]
        output += "\n\n[ {0} - {1} ] Size prefix of chunk23: {2}".format(hex(cursor_prev), hex(cursor-1)  , hex(tmp_chunk))
        retval["chunk22"] = hex(tmp_chunk)


        # chunk 23
        cursor_prev = cursor
        cursor += tmp_chunk

        tmp_chunk = zlib.decompress(content[cursor_prev : cursor])
        output += "\n[ {0} - {1} ] Decompressing chunk23:\n {2}".format(hex(cursor_prev), hex(cursor-1), hexdump(tmp_chunk))
        retval["chunk23"] = tmp_chunk

        writefile("./outdir/out23.bin", tmp_chunk)

        print(output)
        return retval
    
    except Exception as err:
        print(err)


## main

if(len(sys.argv) != 2):
    quit("Usage: {} SAVEGAME.xxx".format(sys.argv[0]))


binary_data = open_jazzfile(sys.argv[1])
jazz_obect = parse_jazzfile(binary_data)

# If the console output didn't help you: 
# You can use jazz_object to perform more operations (like patching and/or 
# comparasions with raw bytes)