variable "subject_model" {
  description = "Human-readable name for the subject model (used in result records)"
  type        = string
  default     = "llama3.2-1b-instruct"
}

variable "subject_model_path" {
  description = "Absolute path to the subject model GGUF file on the host"
  type        = string
  default     = "/home/mazi-main/.local/share/models/Llama-3.2-1B-Instruct-Q4_K_M.gguf"
}

variable "judge_model" {
  description = "Human-readable name for the judge model (used in result records)"
  type        = string
  default     = "llama3.1-8b-instruct"
}

variable "judge_model_path" {
  description = "Absolute path to the judge model GGUF file on the host"
  type        = string
  default     = "/home/mazi-main/.local/share/models/Meta-Llama-3.1-8B-Instruct-Q4_K_M.gguf"
}

variable "models_dir" {
  description = "Host directory containing GGUF model files — bind-mounted read-only into the container"
  type        = string
  default     = "/home/mazi-main/.local/share/models"
}

variable "project_root" {
  description = "Absolute path to the project root on the host (for data volume bind mount)"
  type        = string
}
