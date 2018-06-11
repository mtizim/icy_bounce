-- width,height,diagonal
W,H = love.graphics.getDimensions( )
D = math.sqrt(W*W + H*H)
-- all game constants
c = {
    game = {
        player = {
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
                bounces = {
                    "wall"
                },
                bounce_loss = 0.05,
                boosty_bounces = {
                    "placer"
                }
            }
        },
        placer = {
            block = {
                length = 150,
                width = 15,
                mode = "fill",
            },
            boost = 100,
            offset = 0.1,
            time_to_place = 0.1
        }
    }
}