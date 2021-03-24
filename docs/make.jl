using GitREPL
using Documenter

DocMeta.setdocmeta!(GitREPL, :DocTestSetup, :(using GitREPL); recursive=true)

makedocs(;
    modules=[GitREPL],
    authors="Dilum Aluthge and contributors",
    repo="https://github.com/JuliaVersionControl/GitREPL.jl/blob/{commit}{path}#{line}",
    sitename="GitREPL.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://JuliaVersionControl.github.io/GitREPL.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
    strict=true,
)

deploydocs(;
    repo="github.com/JuliaVersionControl/GitREPL.jl",
    devbranch="main",
)
