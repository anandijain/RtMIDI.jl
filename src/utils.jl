

function list_midi_ports()
    indevice = rtmidi_in_create_default()
    nports = rtmidi_get_port_count(indevice)
    ports = []
    for i in 0:nports-1
        port_name = Base.unsafe_string(rtmidi_get_port_name(indevice, i))
        push!(ports, (i, port_name))
    end
    ports
end

struct EventCB
    handle::Ptr{Cvoid}
    timeStamp::Cdouble
    message::Ptr{Cuchar}
end

# ( double timeStamp , const unsigned char * message , size_t messageSize , void * userData )
function rtmidi_callback_func(timeStamp::Cdouble, message::Ptr{Cuchar}, msg_size::Csize_t, ptr::Ptr{EventCB})::Cvoid
    handle = unsafe_load(ptr, 1).handle
    val = EventCB(handle, timeStamp, message)
    unsafe_store!(ptr, val, 1)
    ccall(:uv_async_send, Cvoid, (Ptr{Cvoid},), handle)
    nothing
end
