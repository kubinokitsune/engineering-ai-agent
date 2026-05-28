import discord
import aiohttp
import json
import os
from dotenv import load_dotenv

load_dotenv(dotenv_path=os.path.join(os.path.dirname(__file__), '..', '.env'))

TOKEN = os.getenv("DISCORD_TOKEN")
OLLAMA_URL = "http://localhost:11434/api/chat"
MODEL = "llama3.1:8b"

SYSTEM_PROMPT = """You are an engineering assistant specializing in F1 in Schools, \
aerodynamics, CAD, and fabrication. Be specific and technical. Give numbers and \
comparisons where possible. Flag anything that needs physical testing."""

intents = discord.Intents.default()
intents.message_content = True
client = discord.Client(intents=intents)


@client.event
async def on_ready():
    print(f"Bot online: {client.user} (ID: {client.user.id})")


@client.event
async def on_message(message):
    # ignore the bot's own messages
    if message.author == client.user:
        return

    # only respond to @mentions or DMs
    if not (client.user.mentioned_in(message) or isinstance(message.channel, discord.DMChannel)):
        return

    # strip the @mention from the message
    content = message.content.replace(f"<@{client.user.id}>", "").strip()
    if not content:
        await message.reply("Ask me anything about your engineering project.")
        return

    async with message.channel.typing():
        try:
            async with aiohttp.ClientSession() as session:
                payload = {
                    "model": MODEL,
                    "messages": [
                        {"role": "system", "content": SYSTEM_PROMPT},
                        {"role": "user", "content": content},
                    ],
                    "stream": False,
                }
                async with session.post(OLLAMA_URL, json=payload) as resp:
                    data = await resp.json()
                    reply = data["message"]["content"]
        except Exception as e:
            reply = f"Error reaching Ollama: {e}\nMake sure Ollama is running."

    # discord has a 2000 char limit per message
    if len(reply) > 1900:
        chunks = [reply[i:i+1900] for i in range(0, len(reply), 1900)]
        await message.reply(chunks[0])
        for chunk in chunks[1:]:
            await message.channel.send(chunk)
    else:
        await message.reply(reply)


client.run(TOKEN)
