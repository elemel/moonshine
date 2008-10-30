local util = require "util"

local map = util.map
local split = util.split
local toarray = util.toarray

local levelmap = [[
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

function newlevel()
    local level = {}
    level.grid = toarray(map(toarray, split(levelmap, "\n")))
    return level
end
