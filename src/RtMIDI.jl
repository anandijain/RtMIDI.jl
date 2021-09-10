module RtMIDI

using rtmidi_jll, Libdl
const VPtr = Ptr{Cvoid}
rtm(sym::Symbol)::VPtr = dlsym(rtmidi_jll.rtmidi_handle, sym)

const RtMidiCCallback = Ptr{Cvoid} 
struct RtMidiInData
    c_callback::RtMidiCCallback
    user_data::Ptr{Cvoid}
end

struct RtMidiWrapper
    ptr::Ptr{Cvoid}
    data::Ptr{RtMidiInData}
    ok::Bool
    msg::Cstring
end
const RtMidiPtr = Ref{RtMidiWrapper}

function rtmidi_sizeof_rtmidi_api()::Int
    Int(ccall((:rtmidi_sizeof_rtmidi_api, rtmidi), Cint, ()))
end

function rtmidi_get_port_count(device::RtMidiPtr)::Int
    Int(ccall((:rtmidi_get_port_count, rtmidi), Cuint, (Ptr{Cvoid},), device))
end

function rtmidi_get_port_name(device::RtMidiPtr, portNumber)::String
    unsafe_string(ccall((:rtmidi_get_port_name, rtmidi), Cstring, (Ptr{Cvoid}, Cuint), device, Cuint(portNumber)))
end

function rtmidi_open_port(device::RtMidiPtr, portNumber, portName)
    ccall((:rtmidi_open_port, rtmidi), Cvoid, (RtMidiPtr, Cuint, Cstring), device, portNumber, portName)
end

function destroy(device::RtMidiPtr)
   ccall((:rtmidi_close_port, rtmidi), Cvoid, (RtMidiPtr,), device)
end

### in

function rtmidi_in_create_default()::RtMidiPtr
    ccall((:rtmidi_in_create_default, rtmidi), RtMidiPtr, ())
end

function rtmidi_in_get_message(device::RtMidiPtr, message, size)
    ccall((:rtmidi_in_get_message, rtmidi), Cdouble, (RtMidiPtr, Ptr{Cstring}, Ptr{Csize_t}), device, message, size)
end

function rtmidi_in_set_callback(device::RtMidiPtr, callback, data)
    ccall((:rtmidi_in_set_callback, rtmidi), Cvoid, (RtMidiPtr, Ptr{Cvoid}, Ptr{Cvoid}), device, callback, data)
end

function rtmidi_in_cancel_callback(device::RtMidiPtr)
    ccall((:rtmidi_in_cancel_callback, rtmidi), Cvoid, (RtMidiPtr,), device)
end

struct EventCB
    handle::Ptr{Cvoid}
    timeStamp::Cdouble
    message::Ptr{Cuchar}
end

function rtmidi_callback_func(timeStamp::Cdouble, message::Ptr{Cuchar}, ptr::Ptr{EventCB})::Cvoid
    handle = unsafe_load(ptr, 1).handle
    val = EventCB(handle, timeStamp, message)
    unsafe_store!(ptr, val, 1)
    ccall(:uv_async_send, Cvoid, (Ptr{Cvoid},), handle)
    nothing
end

### out

function rtmidi_out_create_default()::RtMidiPtr
    ccall((:rtmidi_out_create_default, rtmidi), RtMidiPtr, ())
end

function rtmidi_out_send_message(device::RtMidiPtr, message, length)
    ccall((:rtmidi_out_send_message, rtmidi), Cint, (RtMidiPtr, Ptr{Cuchar}, Cint), device, message, length)
end

export rtm

export RtMidiCCallback, RtMidiInData, RtMidiWrapper, RtMidiPtr, 
rtmidi_sizeof_rtmidi_api, rtmidi_get_port_count, rtmidi_get_port_name, 
rtmidi_open_port, destroy, rtmidi_in_create_default, rtmidi_in_get_message, 
rtmidi_in_set_callback, rtmidi_in_cancel_callback, EventCB, rtmidi_callback_func, 
rtmidi_out_create_default, rtmidi_out_send_message


end # module
