class DrugAi
  MODEL = "gemma2".freeze # By Google
  API_URL = ENV.fetch("OLLAMA_ADDRESS", "http://host.docker.internal:11434")

  def initialize
    @ollama = Ollama.new(
      credentials: { address: API_URL, },
      options: { server_sent_events: true }
    )
  end

  def ask(question, drugs)
    generate <<~PROMPT
      You're a pharmacist and a patient asks you: "#{question}". What would you answer?
      Use the following information as context to provide a better answer and return the response in markdown format:

      #{drugs.map { |drug| "Drug name: #{drug.name}\n#{drug.raw_content}" }.join("\n")}
    PROMPT
  end

  def summarize(drug)
    generate <<~PROMPT
      You're a pharmacist and a patient asks you: "Can you explain or summarize #{drug.name} for me?". What would you answer?
      Use the following information as context to provide a better answer and return the response in markdown format:

      Drug name: #{drug.name}:
      #{drug.raw_content}
    PROMPT
  end

  def format_to_markdown(drug)
    generate <<~PROMPT
      Convert the following text to markdown without any other outputs:
      #{drug.name}
      #{drug.raw_content}
    PROMPT
  end

  private

  def generate(prompt)
    result = @ollama.generate({
                                model: MODEL,
                                prompt: prompt,
                                stream: false,
                                options: {
                                  num_ctx: 8192
                                }
                              })

    result.first["response"]
  end
end
