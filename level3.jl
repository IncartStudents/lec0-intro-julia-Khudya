# Реализовать ниже алгоритм «Игра жизнь»:
# https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life

# Подсказка для граничных условий - тор:
# julia> mod1(10, 30)
# 10
# julia> mod1(31, 30)
# 1

mutable struct GameOfLife
    current_frame::Matrix{Int}
    
    next_frame::Matrix{Int}
end

function stepgame!(state::GameOfLife)
    curr = state.current_frame
    n, m = size(curr)
    next = state.next_frame

    for i in 1:n
        for j in 1:m
            counter = 0
            # перебрали весь массив ну и скинули счетчик
            for ii in -1:1
                for ij in -1:1
                    ni, nj = i + ii, j + ij
                    # перебираем всех соседей
                    if 1 <= ni <= n && 1 <= nj <= m && (ii != 0 || ij != 0)
                        # проверяем на существования живого соеда
                        counter += curr[ni, nj] 
                        # увеличиваем счетчик живих соседей
                    end
                    # println(counter)
                end
            end
            next[i, j] = (counter == 3 || (counter == 2 && curr[i, j] == 1)) ? 1 : 0 # проверка на то выживет ли у нас данная ячйека (? - проверяет на истинность и возвращает 1 или 0)
        end
    end

    # Один шаг алгоритма "Игра жизнь"
state.current_frame, state.next_frame = state.next_frame, state.current_frame

    return nothing
end

using Plots

n = 30
m = 30
# задать начальные условия, чтобы всякие глайдеры делать
init = zeros( n, m)

init[445] = 1.0
init[475] = 1.0
init[505] = 1.0
init[504] = 1.0
init[473] = 1.0

# 

game = GameOfLife(init, zeros(n, m))

anim = @animate for time = 1:100
    stepgame!(game)
    cr = game.current_frame
    heatmap(cr)
    
end
gif(anim, "life.gif", fps = 1)
