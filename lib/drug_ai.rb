class DrugAI
  MODEL = "gemma2".freeze

  def initialize
    @ollama = Ollama.new(
      credentials: { address: ENV.fetch(
        "OLLAMA_ADDRESS", "http://host.docker.internal:11434"
      ), },
      options: { server_sent_events: true }
    )
  end

  def ask(question, drugs)
    prompt = <<~PROMPT
      You're a pharmacist and a patient asks you: "#{question}". What would you answer?
      Use this drugs information to provide a better answer:
      #{drugs.map { |drug| "Drug name: #{drug.name}:\n#{drug.content}" }.join("\n")}
    PROMPT

    result = ollama.generate({
                               model: MODEL,
                               prompt: prompt,
                               stream: false
                             })

    result.first["response"]
  end

  def summarize(drug)
    prompt = <<~PROMPT
      You're a pharmacist and a patient asks you: "Can you summarize #{drug.name} for me?".
      What would you answer?
      Use this drugs information to provide a better answer:
      Drug name: #{drug.name}:
      #{drug.content}
    PROMPT

    result = ollama.generate({
                               model: MODEL,
                               prompt: prompt,
                               stream: false
                             })

    result.first["response"]
  end

  private

  attr_reader :ollama
end
