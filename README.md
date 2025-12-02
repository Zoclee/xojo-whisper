# xojo-whisper
A wrapper module to inference Whisper STT models in Xojo to convert speech to text.

## Installation

1. Clone the xojo-llama repository on your local machine.
2. Create a bin/ folder next to the src/ folder.
3. Download the latest Whisper binaries relevent for your machine architecture from https://github.com/ggml-org/whisper.cpp/releases and extract the contents to the new bin/ folder.
4. In the XOJO IDE, delete the current CopyWhisperBinaries build step for your platform, and replace it with a new one that copies all the files in the bin/ folder (for both debug and release).
5. Download your preferred Whisper model from https://huggingface.co/ggerganov/whisper.cpp/tree/main.
6. You should now be able to do inference on a Whisper model to convert speech to text.

## Support the Project

[![Donate](https://img.shields.io/badge/Donate-PayPal-blue.svg)](https://www.paypal.com/donate/?business=accounts@zoclee.com&no_recurring=0&currency_code=USD)
