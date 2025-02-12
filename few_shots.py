few_shots = [
    {'Question' : "How many fantasy books do we have by Rainbook in Chinese?",
     'SQLQuery' : "SELECT stock_quantity FROM books WHERE publisher = 'Rainbook' AND genre = 'Fantasy' AND lang = 'Chinese'",
     'SQLResult': "Result of the SQL query",
     'Answer' : "58"},
    {'Question' : "What is the total number of books in Russian?",
     'SQLQuery' : "SELECT SUM(stock_quantity) FROM books WHERE lang = 'Russian'",
     'SQLResult': "Result of the SQL query",
     'Answer' : "623"},
    {'Question': "If we have to sell all the Glassowl books today with discounts applied. How much revenue our store will generate (post discounts)?",
     'SQLQuery':"select sum(a.total_amount * ((100-COALESCE(discounts.pct_discount,0))/100)) as total_revenue from (select sum(price*stock_quantity) as total_amount, book_id from books where publisher = 'Glassowl' group by book_id) a left join discounts on a.book_id = discounts.book_id'",
     'SQLResult': "Result of the SQL query",
     'Answer': "28584.95"},
    {'Question': "If we sell them without discount, how much revenue will be generated on books by Reader Series??" ,
     'SQLQuery' : "SELECT SUM(price * stock_quantity) FROM t_shirts WHERE publisher = 'Reader Series'",
     'SQLResult': "Result of the SQL query",
     'Answer': "20067"},
    {'Question': "What publisher do we have the least stock of?",
     'SQLQuery' : "SELECT publisher FROM books group by publisher order by sum(stock_quantity) asc limit 1",
     'SQLResult': "Result of the SQL query",
     'Answer' : "Wooden Letters"},
    {'Question': "How many Chinese books do we have?",
     'SQLQuery' : "SELECT SUM(stock_quantity) FROM books where lang = 'Chinese'",
     'SQLResult': "Result of the SQL query",
     'Answer' : "690"
     }
]