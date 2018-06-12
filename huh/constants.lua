-- width,height,diagonal
W,H = love.graphics.getDimensions( )
D = math.sqrt(W*W + H*H)
-- all game constants
c = {
    game = {
        player = {
            color = {1,1,1},
            start = {
                x = W / 2,
                vx = 0,
                y = H / 2,
                vy = 90,
                gravity = 100
            },
            size = {
                normal = D * 0.02,
                collision = D * 0.02 * 0.7
            },
            collisions = {
                placer = "placer",
                bounces = {
                    "wall"
                },
                bounce_loss = 0.05,
            }
        },
        placer = {
            color = {0,0,1},
            block = {
                length = 150, -- D
                width = 15, -- D
                mode = "fill",
            },
            boost = 100,
            offset = 0.1,
            time_to_place = 0.1
        },
        trail = {
            color = {1,0,0},
            time = {0.5,1},
            movements = {30,30}, -- D notation later
            random_place = {-10,10}, -- D
            every = {0.05,0.1},
            scale = {1,3},
            size = 10
        }
    }
}