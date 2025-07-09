-- Coffee Items (Add these to your ox_inventory/data/items.lua)
-- Coffee Drinks
['espresso'] = {
    label = 'Espresso',
    weight = 200,
    stack = true,
    close = true,
    description = 'A strong shot of coffee with rich flavor and aroma',
    client = {
        image = 'espresso.png',
        usetime = 2500,
        prop = {
            model = 'prop_coffee_cup',
            pos = vec3(0.06, 0.04, 0.06),
            rot = vec3(220.0, 0.0, 0.0)
        },
        anim = {
            dict = 'amb@world_human_aa_coffee@idle_a',
            clip = 'idle_a'
        }
    }
},

['cappuccino'] = {
    label = 'Cappuccino',
    weight = 250,
    stack = true,
    close = true,
    description = 'Espresso topped with steamed milk foam',
    client = {
        image = 'cappuccino.png',
        usetime = 2500,
        prop = {
            model = 'prop_coffee_cup',
            pos = vec3(0.06, 0.04, 0.06),
            rot = vec3(220.0, 0.0, 0.0)
        },
        anim = {
            dict = 'amb@world_human_aa_coffee@idle_a',
            clip = 'idle_a'
        }
    }
},

['latte'] = {
    label = 'Latte',
    weight = 300,
    stack = true,
    close = true,
    description = 'Smooth espresso with plenty of steamed milk',
    client = {
        image = 'latte.png',
        usetime = 2500,
        prop = {
            model = 'prop_coffee_cup',
            pos = vec3(0.06, 0.04, 0.06),
            rot = vec3(220.0, 0.0, 0.0)
        },
        anim = {
            dict = 'amb@world_human_aa_coffee@idle_a',
            clip = 'idle_a'
        }
    }
},

['americano'] = {
    label = 'Americano',
    weight = 250,
    stack = true,
    close = true,
    description = 'Espresso diluted with hot water for a milder taste',
    client = {
        image = 'americano.png',
        usetime = 2500,
        prop = {
            model = 'prop_coffee_cup',
            pos = vec3(0.06, 0.04, 0.06),
            rot = vec3(220.0, 0.0, 0.0)
        },
        anim = {
            dict = 'amb@world_human_aa_coffee@idle_a',
            clip = 'idle_a'
        }
    }
},

['mocha'] = {
    label = 'Mocha',
    weight = 300,
    stack = true,
    close = true,
    description = 'Chocolate-flavored coffee drink with steamed milk',
    client = {
        image = 'mocha.png',
        usetime = 2500,
        prop = {
            model = 'prop_coffee_cup',
            pos = vec3(0.06, 0.04, 0.06),
            rot = vec3(220.0, 0.0, 0.0)
        },
        anim = {
            dict = 'amb@world_human_aa_coffee@idle_a',
            clip = 'idle_a'
        }
    }
},

['macchiato'] = {
    label = 'Macchiato',
    weight = 280,
    stack = true,
    close = true,
    description = 'Espresso with a dollop of foamed milk and caramel',
    client = {
        image = 'macchiato.png',
        usetime = 2500,
        prop = {
            model = 'prop_coffee_cup',
            pos = vec3(0.06, 0.04, 0.06),
            rot = vec3(220.0, 0.0, 0.0)
        },
        anim = {
            dict = 'amb@world_human_aa_coffee@idle_a',
            clip = 'idle_a'
        }
    }
},

['frappe'] = {
    label = 'Frappé',
    weight = 350,
    stack = true,
    close = true,
    description = 'Iced coffee drink blended with milk and ice',
    client = {
        image = 'frappe.png',
        usetime = 2500,
        prop = {
            model = 'prop_plastic_cup_02',
            pos = vec3(0.06, 0.04, 0.06),
            rot = vec3(220.0, 0.0, 0.0)
        },
        anim = {
            dict = 'amb@world_human_drinking@coffee@male@idle_a',
            clip = 'idle_a'
        }
    }
},

['irish_coffee'] = {
    label = 'Irish Coffee',
    weight = 300,
    stack = true,
    close = true,
    description = 'Coffee with Irish whiskey, cream, and sugar',
    client = {
        image = 'irish_coffee.png',
        usetime = 2500,
        prop = {
            model = 'prop_ceramic_jug_01',
            pos = vec3(0.06, 0.04, 0.06),
            rot = vec3(220.0, 0.0, 0.0)
        },
        anim = {
            dict = 'amb@world_human_aa_coffee@idle_a',
            clip = 'idle_a'
        }
    }
},

-- Coffee Ingredients
['coffee_beans'] = {
    label = 'Coffee Beans',
    weight = 50,
    stack = true,
    close = true,
    description = 'Premium roasted coffee beans for brewing',
    client = {
        image = 'coffee_beans.png',
    }
},

['water'] = {
    label = 'Water',
    weight = 100,
    stack = true,
    close = true,
    description = 'Clean filtered water for brewing',
    client = {
        image = 'water.png',
    }
},

['milk'] = {
    label = 'Milk',
    weight = 150,
    stack = true,
    close = true,
    description = 'Fresh milk for coffee drinks',
    client = {
        image = 'milk.png',
    }
},

['chocolate'] = {
    label = 'Chocolate',
    weight = 75,
    stack = true,
    close = true,
    description = 'Rich chocolate for flavoring coffee',
    client = {
        image = 'chocolate.png',
    }
},

['caramel'] = {
    label = 'Caramel',
    weight = 50,
    stack = true,
    close = true,
    description = 'Sweet caramel syrup for coffee',
    client = {
        image = 'caramel.png',
    }
},

['ice'] = {
    label = 'Ice',
    weight = 25,
    stack = true,
    close = true,
    description = 'Ice cubes for cold coffee drinks',
    client = {
        image = 'ice.png',
    }
},

['sugar'] = {
    label = 'Sugar',
    weight = 25,
    stack = true,
    close = true,
    description = 'Sugar for sweetening coffee',
    client = {
        image = 'sugar.png',
    }
},

['cream'] = {
    label = 'Cream',
    weight = 100,
    stack = true,
    close = true,
    description = 'Heavy cream for rich coffee drinks',
    client = {
        image = 'cream.png',
    }
},

['whiskey'] = {
    label = 'Whiskey',
    weight = 200,
    stack = true,
    close = true,
    description = 'Irish whiskey for spiked coffee',
    client = {
        image = 'whiskey.png',
    }
},