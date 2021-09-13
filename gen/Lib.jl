module Lib

using rtmidi_jll
export rtmidi_jll

using CEnum



# typedef void ( * RtMidiErrorCallback ) ( RtMidiError : : Type type , const std : : string & errorText , void * userData )
const RtMidiErrorCallback = Ptr{Cvoid}

function RtMidi_setCoreMidiClientSingleton(client)
    ccall((:RtMidi_setCoreMidiClientSingleton, librtmidi), Cvoid, (Cint,), client)
end

# no prototype is found for this function at RtMidi.h:645:6, please use with caution
function RtMidi_disposeCoreMidiClientSingleton()
    ccall((:RtMidi_disposeCoreMidiClientSingleton, librtmidi), Cvoid, ())
end

struct RtMidiWrapper
    ptr::Ptr{Cvoid}
    data::Ptr{Cvoid}
    ok::Bool
    msg::Ptr{Cchar}
end

const RtMidiPtr = Ptr{RtMidiWrapper}

const RtMidiInPtr = Ptr{RtMidiWrapper}

const RtMidiOutPtr = Ptr{RtMidiWrapper}

@cenum RtMidiApi::UInt32 begin
    RTMIDI_API_UNSPECIFIED = 0
    RTMIDI_API_MACOSX_CORE = 1
    RTMIDI_API_LINUX_ALSA = 2
    RTMIDI_API_UNIX_JACK = 3
    RTMIDI_API_WINDOWS_MM = 4
    RTMIDI_API_RTMIDI_DUMMY = 5
    RTMIDI_API_NUM = 6
end

@cenum RtMidiErrorType::UInt32 begin
    RTMIDI_ERROR_WARNING = 0
    RTMIDI_ERROR_DEBUG_WARNING = 1
    RTMIDI_ERROR_UNSPECIFIED = 2
    RTMIDI_ERROR_NO_DEVICES_FOUND = 3
    RTMIDI_ERROR_INVALID_DEVICE = 4
    RTMIDI_ERROR_MEMORY_ERROR = 5
    RTMIDI_ERROR_INVALID_PARAMETER = 6
    RTMIDI_ERROR_INVALID_USE = 7
    RTMIDI_ERROR_DRIVER_ERROR = 8
    RTMIDI_ERROR_SYSTEM_ERROR = 9
    RTMIDI_ERROR_THREAD_ERROR = 10
end

# typedef void ( * RtMidiCCallback ) ( double timeStamp , const unsigned char * message , size_t messageSize , void * userData )
const RtMidiCCallback = Ptr{Cvoid}

function rtmidi_get_compiled_api(apis, apis_size)
    ccall((:rtmidi_get_compiled_api, librtmidi), Cint, (Ptr{RtMidiApi}, Cuint), apis, apis_size)
end

function rtmidi_api_name(api)
    ccall((:rtmidi_api_name, librtmidi), Ptr{Cchar}, (RtMidiApi,), api)
end

function rtmidi_api_display_name(api)
    ccall((:rtmidi_api_display_name, librtmidi), Ptr{Cchar}, (RtMidiApi,), api)
end

function rtmidi_compiled_api_by_name(name)
    ccall((:rtmidi_compiled_api_by_name, librtmidi), RtMidiApi, (Ptr{Cchar},), name)
end

function rtmidi_error(type, errorString)
    ccall((:rtmidi_error, librtmidi), Cvoid, (RtMidiErrorType, Ptr{Cchar}), type, errorString)
end

function rtmidi_open_port(device, portNumber, portName)
    ccall((:rtmidi_open_port, librtmidi), Cvoid, (RtMidiPtr, Cuint, Ptr{Cchar}), device, portNumber, portName)
end

function rtmidi_open_virtual_port(device, portName)
    ccall((:rtmidi_open_virtual_port, librtmidi), Cvoid, (RtMidiPtr, Ptr{Cchar}), device, portName)
end

function rtmidi_close_port(device)
    ccall((:rtmidi_close_port, librtmidi), Cvoid, (RtMidiPtr,), device)
end

function rtmidi_get_port_count(device)
    ccall((:rtmidi_get_port_count, librtmidi), Cuint, (RtMidiPtr,), device)
end

function rtmidi_get_port_name(device, portNumber)
    ccall((:rtmidi_get_port_name, librtmidi), Ptr{Cchar}, (RtMidiPtr, Cuint), device, portNumber)
end

function rtmidi_in_create_default()
    ccall((:rtmidi_in_create_default, librtmidi), RtMidiInPtr, ())
end

function rtmidi_in_create(api, clientName, queueSizeLimit)
    ccall((:rtmidi_in_create, librtmidi), RtMidiInPtr, (RtMidiApi, Ptr{Cchar}, Cuint), api, clientName, queueSizeLimit)
end

function rtmidi_in_free(device)
    ccall((:rtmidi_in_free, librtmidi), Cvoid, (RtMidiInPtr,), device)
end

function rtmidi_in_get_current_api(device)
    ccall((:rtmidi_in_get_current_api, librtmidi), RtMidiApi, (RtMidiPtr,), device)
end

function rtmidi_in_set_callback(device, callback, userData)
    ccall((:rtmidi_in_set_callback, librtmidi), Cvoid, (RtMidiInPtr, RtMidiCCallback, Ptr{Cvoid}), device, callback, userData)
end

function rtmidi_in_cancel_callback(device)
    ccall((:rtmidi_in_cancel_callback, librtmidi), Cvoid, (RtMidiInPtr,), device)
end

function rtmidi_in_ignore_types(device, midiSysex, midiTime, midiSense)
    ccall((:rtmidi_in_ignore_types, librtmidi), Cvoid, (RtMidiInPtr, Bool, Bool, Bool), device, midiSysex, midiTime, midiSense)
end

function rtmidi_in_get_message(device, message, size)
    ccall((:rtmidi_in_get_message, librtmidi), Cdouble, (RtMidiInPtr, Ptr{Cuchar}, Ptr{Csize_t}), device, message, size)
end

function rtmidi_out_create_default()
    ccall((:rtmidi_out_create_default, librtmidi), RtMidiOutPtr, ())
end

function rtmidi_out_create(api, clientName)
    ccall((:rtmidi_out_create, librtmidi), RtMidiOutPtr, (RtMidiApi, Ptr{Cchar}), api, clientName)
end

function rtmidi_out_free(device)
    ccall((:rtmidi_out_free, librtmidi), Cvoid, (RtMidiOutPtr,), device)
end

function rtmidi_out_get_current_api(device)
    ccall((:rtmidi_out_get_current_api, librtmidi), RtMidiApi, (RtMidiPtr,), device)
end

function rtmidi_out_send_message(device, message, length)
    ccall((:rtmidi_out_send_message, librtmidi), Cint, (RtMidiOutPtr, Ptr{Cuchar}, Cint), device, message, length)
end

# Skipping MacroDefinition: RTMIDI_DLL_PUBLIC __attribute__ ( ( visibility ( "default" ) ) )

const RTMIDI_VERSION = "4.0.0"

const RTMIDIAPI = nothing

end # module
