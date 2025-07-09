Config = {}

-- Job Requirements
Config.jobRequired = false -- Set to false to disable job requirement
Config.allowedJobs = {'cafe', 'restaurant', 'chef'} -- Add allowed job names

-- Coffee Machines
Config.coffeeMachines = {
    {
        coords = vector4(-291.2057, -87.17043, 49.455, 161.0), -- Vanilla Unicorn area
        label = 'Coffee Machine',
        prop = 'prop_coffee_mac_02', -- Coffee machine prop
        showBlip = true
    },
    {
        coords = vector4(-627.82, -230.95, 38.05, 120.0), -- Another location
        label = 'Cafe Coffee Machine',
        prop = 'prop_coffee_mac_02',
        showBlip = true
    },
    -- Add more coffee machines here
    -- {
    --     coords = vector4(x, y, z, heading),
    --     label = 'Coffee Machine Name',
    --     prop = 'prop_coffee_mac_02',
    --     showBlip = true
    -- },
}

-- Coffee Types and Recipes
Config.coffeeTypes = {
    ['espresso'] = {
        label = 'Espresso',
        image = 'espresso.png', -- Place this image in images/ folder
        ingredients = {
            ['coffee_beans'] = 2,
            ['water'] = 1
        },
        price = 0 -- Optional price for display
    },
    
    ['cappuccino'] = {
        label = 'Cappuccino',
        image = 'cappuccino.png',
        ingredients = {
            ['coffee_beans'] = 2,
            ['milk'] = 1,
            ['water'] = 1
        },
        price = 0
    },
    
    ['latte'] = {
        label = 'Latte',
        image = 'latte.png',
        ingredients = {
            ['coffee_beans'] = 2,
            ['milk'] = 2,
            ['water'] = 1
        },
        price = 0
    },
    
    ['americano'] = {
        label = 'Americano',
        image = 'americano.png',
        ingredients = {
            ['coffee_beans'] = 1,
            ['water'] = 2
        },
        price = 0
    },
    
    ['mocha'] = {
        label = 'Mocha',
        image = 'mocha.png',
        ingredients = {
            ['coffee_beans'] = 2,
            ['milk'] = 1,
            ['chocolate'] = 1,
            ['water'] = 1
        },
        price = 0
    },
    
    ['macchiato'] = {
        label = 'Macchiato',
        image = 'macchiato.png',
        ingredients = {
            ['coffee_beans'] = 2,
            ['milk'] = 1,
            ['caramel'] = 1,
            ['water'] = 1
        },
        price = 0
    },
    
    -- ['frappe'] = {
    --     label = 'Frappé',
    --     image = 'frappe.png',
    --     ingredients = {
    --         ['coffee_beans'] = 1,
    --         ['milk'] = 1,
    --         ['ice'] = 2,
    --         ['sugar'] = 1
    --     },
    --     price = 20
    -- },
    
    -- ['irish_coffee'] = {
    --     label = 'Irish Coffee',
    --     image = 'irish_coffee.png',
    --     ingredients = {
    --         ['coffee_beans'] = 2,
    --         ['whiskey'] = 1,
    --         ['cream'] = 1,
    --         ['sugar'] = 1,
    --         ['water'] = 1
    --     },
    --     price = 35
    -- }
}

-- UI Settings
Config.ui = {
    animationDuration = 6000, -- 6 seconds crafting animation
    theme = 'dark' -- 'dark' or 'light'
}