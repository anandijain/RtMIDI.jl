nms = names(RtMIDI)

api_functions = Symbol.(filter(startswith("rtmidi_"), string.(nms)))
deleteat!(api_functions, api_functions .== :rtmidi_callback_func);

for f in api_functions
    rtm(f)
end

@test length(api_functions) == 9
