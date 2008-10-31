local mimic = require "mimic"

local map = mimic.map
local split = mimic.split
local to_array = mimic.to_array

local level_map = [[
###############################################################################
#                                                                             #
#                                                                             #
#                                                                             #
#                                                    ##########               #
#                  ########                          #                        #
#                         #                          #                        #
#                         #                          ################         #
#                         #                                         #         #
#      #                  #                                         #         #
#      #                                                            #         #
#      #                                  ###########               #         #
#      #                                  #         #                         #
#      #######################            #         #                         #
#           #                                       #                         #
#           #                                       #                         #
#           #                                       #                         #
#           #                                                                 #
#                                                                             #
#                                                                             #
#                                                                             #
###############################################################################
]]

function new_level()
    local level = {}
    level.grid = to_array(map(to_array, split(level_map, "\n")))
    return level
end
