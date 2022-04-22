using CairoMakie
using DataFrames
using CSV

# load data
df = DataFrame(CSV.File("results.csv"))
replace!(df.f, "*" => "matmul")
blasorder = Dict("MKL" => 1, "BLIS" => 2, "OpenBLAS" => 3)
sort!(df, [:pinning, order(:BLAS, by=x -> blasorder[x]), :f, :size])
nsizes = nrow(subset(df, :f => x -> x .== "svd", :BLAS => x -> x .== "OpenBLAS", :pinning => x -> x .== "highAI"))

group_labels = unique(df.BLAS)
ngrps = length(group_labels)
blas2grp(str) = findfirst(isequal(str), group_labels)
grpranges = collect(Iterators.partition(1:ngrps*nsizes, nsizes))
funcs = ["eigen", "cholesky", "svd", "matmul"] # specifying the order
ncols = length(funcs)

@assert nrow(df) == length(funcs) * nsizes * ngrps * length(unique(df.pinning))

colors = Makie.wong_colors()
f = Figure(resolution=(1400, 800))
# highAI
# runtime plots highai
dfai = df[df.pinning.=="highAI", :]
for j in 1:ncols
    local df = dfai[dfai.f.==funcs[j], :]
    ax = Axis(f[1, j])
    if j == 1
        ax.ylabel = "Min. runtime [s]"
    end
    ax.xticks = (1:ngrps, string.(unique(df.size)))
    ax.title = first(df.f)
    grp = blas2grp.(df.BLAS)
    barplot!(ax, repeat(1:ngrps, nsizes), df.time,
        dodge=grp,
        color=colors[grp])
end
# normalized plots highai
for j in 1:ncols
    local df = dfai[dfai.f.==funcs[j], :]
    ax = Axis(f[2, j])
    if j == 1
        ax.ylabel = "Normalized to MKL"
    end
    ax.xticks = (1:ngrps, string.(unique(df.size)))
    ax.title = first(df.f)
    grp = blas2grp.(df.BLAS)
    mkltimes = df[grpranges[blas2grp("MKL")], :time]
    blistimes = df[grpranges[blas2grp("BLIS")], :time]
    openblastimes = df[grpranges[blas2grp("OpenBLAS")], :time]
    barplot!(ax, repeat(1:ngrps, nsizes), vcat(fill(1.0, nsizes), blistimes ./ mkltimes, openblastimes ./ mkltimes),
        dodge=grp,
        color=colors[grp])
end
f[0, 1:ncols] = Label(f, "highAI", textsize=25)

# highMB
f[4, 1:ncols] = Label(f, "highMB", textsize=25)
dfmb = df[df.pinning.=="highMB", :]
# runtime plots highMB
for j in 1:ncols
    local df = dfmb[dfmb.f.==funcs[j], :]
    ax = Axis(f[5, j])
    if j == 1
        ax.ylabel = "Min. runtime [s]"
    end
    ax.xticks = (1:ngrps, string.(unique(df.size)))
    ax.title = first(df.f)
    grp = blas2grp.(df.BLAS)
    barplot!(ax, repeat(1:ngrps, nsizes), df.time,
        dodge=grp,
        color=colors[grp])
end
# normalized plots highMB
for j in 1:ncols
    local df = dfmb[dfmb.f.==funcs[j], :]
    ax = Axis(f[6, j])
    if j == 1
        ax.ylabel = "Normalized to MKL"
    end
    ax.xticks = (1:ngrps, string.(unique(df.size)))
    ax.title = first(df.f)
    grp = blas2grp.(df.BLAS)
    mkltimes = df[grpranges[blas2grp("MKL")], :time]
    blistimes = df[grpranges[blas2grp("BLIS")], :time]
    openblastimes = df[grpranges[blas2grp("OpenBLAS")], :time]
    barplot!(ax, repeat(1:ngrps, nsizes), vcat(fill(1.0, nsizes), blistimes ./ mkltimes, openblastimes ./ mkltimes),
        dodge=grp,
        color=colors[grp])
end
# Legend
elements = [PolyElement(polycolor=colors[i]) for i in 1:length(group_labels)]
Legend(f[1:6, ncols+1], elements, group_labels)

save("figure.png", f)