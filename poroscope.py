import nltk
import random
nltk.download('punkt')
from nltk.util import ngrams
from collections import defaultdict

# Preprocess the data by tokenizing it into individual words
inputs = [
  "Aries: You will have a great day today!",
  "Scorpio: Be prepared for a surprise today!",
  "Capricorn: Expect the unexpected today!",
  "Taurus: Things will go your way today!",
  "Aquarius: You will have a lucky day today!",
  "Aries: Positive changes are coming your way today!",
  "Gemini: Today is a great day to try something new!",
  "Sagittarius: Expect to have a productive day today!",
  "Leo: You will have a breakthrough today!"
]
tokens = []

for input in inputs:
  tokens.extend(nltk.word_tokenize(input))

# Build a Markov chain model using bigrams (pairs of adjacent words)
model = defaultdict(list)
bigrams = ngrams(tokens, 2)
for prev, curr in bigrams:
  model[prev].append(curr)

# Generate a new horoscope prompt using the Markov chain model
def generateHoroscope(sign):
  prompt = ""
  prev = sign
  while True:
    curr = random.choice(model[prev])
    prompt += curr + " "
    if curr[-1] in [".", "!", "?"]:
      return prompt
    prev = curr
