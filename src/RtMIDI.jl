module RtMIDI

include("../gen/Lib.jl")
using .Lib:
    RtMidiCCallback, RtMidiWrapper, RtMidiPtr,
    rtmidi_get_port_count, rtmidi_get_port_name,
    rtmidi_open_port, rtmidi_in_create_default, rtmidi_in_get_message,
    rtmidi_in_set_callback, rtmidi_in_cancel_callback,
    rtmidi_out_create_default, rtmidi_out_send_message

export
    RtMidiCCallback, RtMidiWrapper, RtMidiPtr,
    rtmidi_get_port_count, rtmidi_get_port_name,
    rtmidi_open_port, rtmidi_in_create_default, rtmidi_in_get_message,
    rtmidi_in_set_callback, rtmidi_in_cancel_callback,
    rtmidi_out_create_default, rtmidi_out_send_message

end # module
