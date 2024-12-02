"""
    CaliforniaBightNitrate

A micro-package™️ providing interpolation into the California Bight temperature-nitrate 
relation found by [Snyder et al. (2020)](https://doi.org/10.3389/fmars.2020.00022), 
as available from the [SBCLTER](https://doi.org/10.6073/pasta/fccdb501ac45aa44d457ed0d5a047640).
"""
module CaliforniaBightNitrate

export nitrate

using Artifacts, Interpolations, JLD2

const DATA_PATH = joinpath(artifact"SBCLTER", "interpolations.jld2")

file = jldopen(DATA_PATH)

const VALUES = file["VALUES"]
const ERRORS = file["ERRORS"]
const OPTIONS = file["OPTIONS"]

close(file)

"""
    nitrate(temp; option = :summer, return_error = false)

Returns the nitrate value at `temp` in the region or season specified by `option`.
If `return_error` is true then the error is also returned.
"""
function nitrate(temp; option = :summer, return_error = false)
    option in OPTIONS || throw(ArgumentError("$option is not a supported option ($OPTIONS)"))
    
    if return_error
        return VALUES[option](temp), ERRORS[option](temp)
    else
        return VALUES[option](temp)
    end
end

end # module CaliforniaBiteNitrate
