using RtMIDI, Test

# in 
indevice = rtmidi_in_create_default()
api = rtmidi_in_get_current_api(indevice)

# in this town all my homies use ALSA
if Sys.islinux()
    @test api == RtMIDI.Lib.RtMidiApi(2)
elseif Sys.isapple()
    @test api == RtMIDI.Lib.RtMidiApi(1)
else
    @info api "write a test for this"
end

nports = rtmidi_get_port_count(indevice)
port_names = String[]
for i in 0:nports-1
    port_name = Base.unsafe_string(rtmidi_get_port_name(indevice, i))
    push!(port_names, port_name)
    @info i, port_name
end

inport = rtmidi_open_virtual_port(indevice, "foobar")

rtmidi_close_port(indevice)
rtmidi_in_free(indevice)
# nports = rtmidi_get_port_count(indevice) # causes segfault (i maybe it shouldn't do that)
# @test rtmidi_

# out 
outdevice = rtmidi_out_create_default()
api = rtmidi_out_get_current_api(outdevice)
