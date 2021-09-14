# RtMIDI.jl

all credit to https://github.com/wookay/PushInterface.jl


Reading input 

```julia 
ports = list_midi_ports()
device = rtmidi_in_create_default()
rtmidi_open_port(device, ports[1]...)

cb_ptr = @cfunction rtmidi_callback_func Cvoid (Cdouble, Ptr{Cuchar}, Csize_t, Ptr{EventCB})
cond = Base.AsyncCondition()
handle = Base.unsafe_convert(Ptr{Cvoid}, cond)
ecb = EventCB(handle, 0, C_NULL)
r_ecb = Ref(ecb)
rtmidi_in_set_callback(device, cb_ptr, r_ecb)

function _callback_async_loop(cond, r_ecb)
    while isopen(cond)
        wait(cond)
        msg = codeunits(unsafe_string(r_ecb[].message))
        @info msg
    end
end

cbloop = Task() do
    _callback_async_loop(cond, r_ecb)
end

schedule(cbloop)

# now play MIDI device corresponding to `ports[1]`

```
