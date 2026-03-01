import streamlit as st
import base64
from groq import Groq
import google.generativeai as genai
from openai import OpenAI
from gtts import gTTS

# --- Configuração da Página ---
st.set_page_config(page_title="FluencyForge Pro", page_icon="🎙️")

# --- Acesso Seguro aos Secrets ---
# O Streamlit busca automaticamente no arquivo .streamlit/secrets.toml (local)
# ou nas configurações do dashboard (Cloud)
try:
    GROQ_KEY = st.secrets["GROQ_API_KEY"]
    GEMINI_KEY = st.secrets["GEMINI_API_KEY"]
    OPENAI_KEY = st.secrets["OPENAI_API_KEY"]
except KeyError as e:
    st.error(f"Erro: Chave {e} não encontrada no st.secrets. Verifique as configurações.")
    st.stop()

# --- Inicialização dos Clientes ---
client_groq = Groq(api_key=GROQ_KEY)
genai.configure(api_key=GEMINI_KEY)
client_openai = OpenAI(api_key=OPENAI_KEY)

def get_ai_response(messages):
    """Lógica de Failover: Tenta Groq -> Gemini -> OpenAI"""
    
    # 1. Tentativa com Groq (Llama 3.3) - Prioridade pela velocidade
    try:
        response = client_groq.chat.completions.create(
            model="llama-3.3-70b-versatile",
            messages=messages
        )
        return response.choices[0].message.content, "Groq (Llama)"
    except Exception as e:
        st.warning(f"Groq offline: {e}. Alternando para Gemini...")

    # 2. Tentativa com Gemini (1.5 Flash) - Backup robusto
    try:
        model = genai.GenerativeModel('gemini-1.5-flash')
        # Simplificando o histórico para o Gemini
        prompt = f"System Context: {messages[0]['content']}\n\nUser: {messages[-1]['content']}"
        response = model.generate_content(prompt)
        return response.text, "Google Gemini"
    except Exception as e:
        st.warning(f"Gemini offline: {e}. Alternando para OpenAI...")

    # 3. Última instância: OpenAI (GPT-4o-mini)
    try:
        response = client_openai.chat.completions.create(
            model="gpt-4o-mini",
            messages=messages
        )
        return response.choices[0].message.content, "OpenAI"
    except Exception:
        return "Sorry, I'm currently unable to connect to any AI models.", "Error"

def play_audio(text):
    """Gera e reproduz áudio automaticamente no navegador"""
    try:
        tts = gTTS(text=text, lang='en')
        tts.save("voice.mp3")
        with open("voice.mp3", "rb") as f:
            data = f.read()
            b64 = base64.b64encode(data).decode()
            st.markdown(f'<audio autoplay="true" src="data:audio/mp3;base64,{b64}">', unsafe_allow_html=True)
    except Exception:
        st.error("Erro ao gerar áudio.")

# --- Interface ---
st.title("🎙️ FluencyForge: Conversa Inteligente")

if "messages" not in st.session_state:
    st.session_state.messages = [
        {"role": "system", "content": "You are a helpful English tutor. Correct grammar mistakes and explain why briefly."}
    ]

# Renderização do Histórico
for msg in st.session_state.messages:
    if msg["role"] != "system":
        with st.chat_message(msg["role"]):
            st.write(msg["content"])

# Entrada de Usuário
if prompt := st.chat_input("Practice your English..."):
    st.session_state.messages.append({"role": "user", "content": prompt})
    with st.chat_message("user"):
        st.write(prompt)

    with st.spinner("Waiting for tutor..."):
        resposta, provider = get_ai_response(st.session_state.messages)
        
    with st.chat_message("assistant"):
        st.markdown(f"**[{provider}]** {resposta}")
        st.session_state.messages.append({"role": "assistant", "content": resposta})
        play_audio(resposta)