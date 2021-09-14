module RtMIDI

include("../gen/Lib.jl")
using .Lib:
    RtMidiCCallback, RtMidiWrapper, RtMidiPtr, rtmidi_get_compiled_api, 
    rtmidi_api_name, rtmidi_api_display_name, rtmidi_compiled_api_by_name, 
    rtmidi_error, rtmidi_open_port, rtmidi_open_virtual_port, rtmidi_close_port, 
    rtmidi_get_port_count, rtmidi_get_port_name, rtmidi_in_create_default, 
    rtmidi_in_create, rtmidi_in_free, rtmidi_in_get_current_api, rtmidi_in_set_callback, 
    rtmidi_in_cancel_callback, rtmidi_in_ignore_types, rtmidi_in_get_message, 
    rtmidi_out_create_default, rtmidi_out_create, rtmidi_out_free, 
    rtmidi_out_get_current_api, rtmidi_out_send_message

export
    RtMidiCCallback, RtMidiWrapper, RtMidiPtr, rtmidi_get_compiled_api, 
    rtmidi_api_name, rtmidi_api_display_name, rtmidi_compiled_api_by_name, 
    rtmidi_error, rtmidi_open_port, rtmidi_open_virtual_port, rtmidi_close_port, 
    rtmidi_get_port_count, rtmidi_get_port_name, rtmidi_in_create_default, 
    rtmidi_in_create, rtmidi_in_free, rtmidi_in_get_current_api, rtmidi_in_set_callback, 
    rtmidi_in_cancel_callback, rtmidi_in_ignore_types, rtmidi_in_get_message, 
    rtmidi_out_create_default, rtmidi_out_create, rtmidi_out_free, 
    rtmidi_out_get_current_api, rtmidi_out_send_message

end # module
