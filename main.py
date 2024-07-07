import streamlit as st
from sql_prompt import get_few_shot_db_chain

st.title("Bookstore: Database Enquiry System 📚")

question = st.text_input("Question: ")

if question:
    chain = get_few_shot_db_chain()
    response = chain.run(question)

    st.header("Answer")
    st.write(response)