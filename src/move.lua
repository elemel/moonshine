local function unlink(obj, env)
    if obj.next_inv == obj then
        env.first_inv = nil
    else
        if env.first_inv == obj then
            env.first_inv = obj.next_inv
        end
        obj.prev_inv.next_inv = obj.next_inv
        obj.next_inv.prev_inv = obj.prev_inv
    end
    obj.env = nil
    obj.prev_inv = nil
    obj.next_inv = nil    
end

local function link(obj, env)
    if env.first_inv == nil then
        obj.prev_inv = obj
        obj.next_inv = obj
    else
        obj.prev_inv = env.first_inv.prev_inv
        obj.prev_inv.next_inv = obj
        obj.next_inv = env.first_inv
        env.first_inv.prev_inv = obj
    end
    obj.env = env
    env.first_inv = obj
end

local function move(obj, env)
    if obj.env then
        unlink(obj, obj.env)
    end
    if env then
        link(obj, env)
    end
end

return move
