#!/usr/bin/bash

# Function to XOR a string with a key
xor_string() {
    local input="$1"
    local key="$2"
    local output=""
    local input_len=${#input}
    local key_len=${#key}

    for (( i=0; i<input_len; i++ )); do
        # Get the ASCII value of the input character
        input_char=$(printf '%d' "'${input:i:1}")
        
        # Get the ASCII value of the key character (key is cycled if shorter than input)
        key_char=$(printf '%d' "'${key:i%key_len:1}")

        # XOR the ASCII values
        xor_result=$((input_char ^ key_char))

        # Convert the result to a two-character hex string and append to output
        output+=$(printf '%02x' "$xor_result")
    done
    echo "$output"
}

# Function to decrypt a hex string with a key
decrypt_xor_hex_string() {
    local hex_input="$1"
    local key="$2"
    local output=""
    local key_len=${#key}

    for (( i=0; i<${#hex_input}; i+=2 )); do
        # Extract a pair of hex characters
        hex_pair="${hex_input:i:2}"

        # Convert hex to a character
        char=$(printf "%d" "0x$hex_pair")

        # Get the ASCII value of the key character (key is cycled if shorter than input)
        key_char=$(printf '%d' "'${key:i/2%key_len:1}")

        # XOR the ASCII value with the key
        xor_result=$((char ^ key_char))

        # Convert the result to a character and append to output
        output+=$(printf \\$(printf '%03o' "$xor_result"))
    done
    echo "$output"
}

if [[ -z $1 || -z $2 ]] ; then
	echo "USAGE: cipher.sh \"phrase\" \"key\""
	exit 1
fi

plaintext="$1"
key="$2"

# Encrypt
encrypted=$(xor_string "$plaintext" "$key")
echo "Encrypted: $encrypted"

# Decrypt
decrypted=$(decrypt_xor_hex_string "$encrypted" "$key")
echo "Decrypted: $decrypted"
