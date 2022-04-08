using CairoMakie
using DataFrames
using CSV

# load data
dfai = DataFrame(CSV.File("results_highAI.csv"))
dfmb = DataFrame(CSV.File("results_highMB.csv"))
replace!(dfai.f, "*" => "matmul")
replace!(dfmb.f, "*" => "matmul")
sort!(dfai, [:pinning, :BLAS, :f, :size])
sort!(dfmb, [:pinning, :BLAS, :f, :size])

blas2grp(str) = Int(str == "OpenBLAS") + 1
group_labels = ["MKL", "OpenBLAS"]
funcs = ["eigen", "cholesky", "svd", "matmul"]
ncols = length(funcs)
colors = Makie.wong_colors()
f = Figure(resolution=(1400, 800))
# highAI
# runtime plots highai
for j in 1:ncols
    ax = Axis(f[1, j])
    df = dfai[dfai.f.==funcs[j], :]
    ax.title = first(df.f)
    if j == 1
        ax.ylabel = "Min. runtime [s]"
    end
    grp = blas2grp.(df.BLAS)
    barplot!(ax, df.size, df.time,
        dodge=grp,
        color=colors[grp])
end
# normalized plots highai
for j in 1:ncols
    ax = Axis(f[2, j])
    df = dfai[dfai.f.==funcs[j], :]
    ax.title = first(df.f)
    if j == 1
        ax.ylabel = "Normalized to MKL"
    end
    grp = blas2grp.(df.BLAS)
    @assert all(df.BLAS[1:3] .== "MKL")
    @assert all(df.BLAS[4:6] .== "OpenBLAS")
    mkltimes = df[1:3, :time]
    openblastimes = df[4:6, :time]
    barplot!(ax, df.size, vcat([1.0, 1.0, 1.0], openblastimes ./ mkltimes),
        dodge=grp,
        color=colors[grp])
end
f[0, 1:ncols] = Label(f, "highAI", textsize=25)

# highMB
f[4, 1:ncols] = Label(f, "highMB", textsize=25)
# runtime plots highMB
for j in 1:ncols
    ax = Axis(f[5, j])
    df = dfmb[dfmb.f.==funcs[j], :]
    ax.title = first(df.f)
    if j == 1
        ax.ylabel = "Min. runtime [s]"
    end
    grp = blas2grp.(df.BLAS)
    barplot!(ax, df.size, df.time,
        dodge=grp,
        color=colors[grp])
end
# normalized plots highMB
for j in 1:ncols
    ax = Axis(f[6, j])
    df = dfmb[dfmb.f.==funcs[j], :]
    ax.title = first(df.f)
    if j == 1
        ax.ylabel = "Normalized to MKL"
    end
    grp = blas2grp.(df.BLAS)
    @assert all(df.BLAS[1:3] .== "MKL")
    @assert all(df.BLAS[4:6] .== "OpenBLAS")
    mkltimes = df[1:3, :time]
    openblastimes = df[4:6, :time]
    barplot!(ax, df.size, vcat([1.0, 1.0, 1.0], openblastimes ./ mkltimes),
        dodge=grp,
        color=colors[grp])
end
# Legend
elements = [PolyElement(polycolor=colors[i]) for i in 1:length(group_labels)]
Legend(f[1:6, ncols+1], elements, group_labels)

save("figure.png", f)