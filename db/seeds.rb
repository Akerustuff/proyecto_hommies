# frozen_string_literal: true

# Seed de House
House.create(
  [{ name: 'Casa default', code: '1111111' },
   { name: 'Casa Hufflepuff', code: '1111111' },
   { name: 'Casa de Slytherin', code: '2222222' },
   { name: 'Casa de Griffyndor', code: '3333333' },
   { name: 'Casa de Ravenclaw', code: '4444444' }]
)

# Seed de User, no funciona
User.create(
  [{ email: 'admin@gmail.com', password: '123456', password_confirmation: '123456',
     first_name: 'Admin', last_name: 'admin', owner: true, birthdate: '1989-11-21', house_id: 1, admin: true },
   { email: 'kelvis@gmail.com', password: '123456', password_confirmation: '123456',
     first_name: 'Kelvis', last_name: 'Alvarez', owner: true, birthdate: '1989-11-21', house_id: 2, admin: true },
   { email: 'jorge@gmail.com',  password: '123456', password_confirmation: '123456',
     first_name: 'Jorge', last_name: 'Nehmer', owner: false, birthdate: '1988-01-06', house_id: 2 },
   { email: 'david@gmail.com',  password: '123456', password_confirmation: '123456',
     first_name: 'David', last_name: 'Chacon', owner: true, birthdate: '1989-08-16', house_id: 3 },
   { email: 'mario@gmail.com',  password: '123456', password_confirmation: '123456',
     first_name: 'Mario', last_name: 'Bros', owner: true, birthdate: '1990-10-15', house_id: 4 },
   { email: 'luigi@gmail.com',  password: '123456', password_confirmation: '123456',
     first_name: 'Luigi', last_name: 'Bros', owner: false, birthdate: '1985-10-05', house_id: 4 }]
)

Task.create(
  [{ name: 'Barrer', description: 'Todo el depa', category: 0, limit_date: '2021-12-20', finished_date: nil,
     approved_date: nil, house_id: 2, owner_id: 1, assignee_id: 2, reviewer_id: nil, aasm_state: 'assigned' },
   { name: 'Lavar', description: 'ropa de color', category: 0, limit_date: '2021-12-19', finished_date: nil,
     approved_date: nil, house_id: 2, owner_id: 1, assignee_id: nil, reviewer_id: nil },
   { name: 'Cocina semanal', description: 'de lunes a viernes', category: 1, limit_date: '2021-12-15',
     finished_date: nil, approved_date: nil, house_id: 2, owner_id: 2, assignee_id: 1, reviewer_id: nil,
     aasm_state: 'assigned' },
   { name: 'Sacar el perro', description: 'En la noche', category: 1, limit_date: '2021-12-30', finished_date: nil,
     approved_date: nil, house_id: 3, owner_id: 3, assignee_id: nil, reviewer_id: nil },
   { name: 'Mercado de carnes', description: 'solo carne roja', category: 2, limit_date: '2021-11-20',
     finished_date: nil, approved_date: nil, house_id: 3, owner_id: 3, assignee_id: 3, reviewer_id: nil,
     aasm_state: 'assigned' },
   { name: 'Mercado de frutas', description: 'frutas de estación', category: 2, limit_date: '2021-12-1',
     finished_date: nil, approved_date: nil, house_id: 4, owner_id: 4, assignee_id: 5, reviewer_id: nil },
   { name: 'Compras de limpieza', description: 'comprar cloro y desinfectante', category: 2, limit_date: '2021-12-2',
     finished_date: nil, approved_date: nil, house_id: 4, owner_id: 5, assignee_id: 5, reviewer_id: nil }]
)

Comment.create(
  [{ content: 'Recuerda barrer la oficina', user_id: 1, task_id: 1 },
   { content: 'Barrí la oficina ayer', user_id: 2, task_id: 1 },
   { content: 'Cierto, lo habia olvidado', user_id: 3, task_id: 4 },
   { content: 'Compra manzanas', user_id: 4, task_id: 6 },
   { content: 'vale, las compro mañana', user_id: 5, task_id: 6 }]
)
