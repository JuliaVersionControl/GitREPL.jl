module GitREPL

import Git
import ReplMaker

export gitrepl

const GIT_REPL_MODE_NAME        = "GitREPL.jl Git REPL mode"
const GIT_REPL_MODE_PROMPT_TEXT = "git> "
const GIT_REPL_MODE_START_KEY   = ','

function _gitrepl_parser(repl_input::AbstractString)
    return quote
        repl_input = $(Expr(:quote, repl_input))
        run(`$(GitREPL.Git.git()) $(split(repl_input))`)
        return nothing
    end
end

"""
    gitrepl()
    gitrepl(; kwargs...)

Set up the Git REPL mode.

## Optional keyword arguments

| Name          | Type             | Default Value                        |
|:------------- | :--------------- |:-------------------------------------|
| `mode_name`   | `AbstractString` | `$(repr(GIT_REPL_MODE_NAME))`        |
| `prompt_text` | `AbstractString` | `$(repr(GIT_REPL_MODE_PROMPT_TEXT))` |
| `start_key`   | `AbstractChar`   | `$(repr(GIT_REPL_MODE_START_KEY))`   |

## Descriptions of optional keyword arguments:

| Name          | Description                                         |
|:------------- | :-------------------------------------------------- |
| `mode_name`   | Name of the REPL mode                               |
| `prompt_text` | Prompt text to display when the REPL mode is active |
| `start_key`   | Key to press to enter the REPL mode                 |

"""
function gitrepl(; mode_name::AbstractString   = GIT_REPL_MODE_NAME,
                   prompt_text::AbstractString = GIT_REPL_MODE_PROMPT_TEXT,
                   start_key::AbstractChar     = GIT_REPL_MODE_START_KEY,
                   kwargs...)
    ReplMaker.initrepl(
        _gitrepl_parser;
        mode_name,
        prompt_text,
        start_key,
        kwargs...
    )
    return nothing
end

function __init__()
    try
        gitrepl()
    catch ex
        msg = "Unable to automatically initialize the Git REPL mode"
        @debug(msg, exception=(ex, catch_backtrace()))
        @warn(msg)
    end
    return nothing
end

end # module
