class Vectorizer
  MODEL = 'mxbai-embed-large'.freeze
  OLLAMA_ADDRESS = ENV.fetch('OLLAMA_ADDRESS', 'http://host.docker.internal:11434').freeze

  def initialize
    @ollama = Ollama.new(
      credentials: { address: OLLAMA_ADDRESS },
      options: { server_sent_events: true }
    )
  end

  def vectorize(text)
    result = ollama.embeddings({
                                 model: MODEL,
                                 prompt: text
                               })

    result.first['embedding']
  end

  def vectorize_query(query)
    result = ollama.embeddings({
                                 model: MODEL,
                                 prompt: "Represent this sentence for searching relevant passages: #{query}"
                               })

    result.first['embedding']
  end

  private

  attr_reader :ollama
end
