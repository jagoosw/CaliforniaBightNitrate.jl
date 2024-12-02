module CaliforniaBightNitrate

export nitrate

using Artifacts, Interpolations, JLD2

const DATA_PATH = joinpath(artifact"SBCLTER", "interpolations.jld2")

file = jldopen(DATA_PATH)

const VALUES = file["VALUES"]
const ERRORS = file["ERRORS"]
const OPTIONS = file["OPTIONS"]

close(file)

function nitrate(temp; option = :summer, return_error = false)
    option in OPTIONS || throw(ArgumentError("$option is not a supported option ($OPTIONS)"))
    
    if return_error
        return VALUES[option](temp), ERRORS[option](temp)
    else
        return VALUES[option](temp)
    end
end

end # module CaliforniaBiteNitrate
