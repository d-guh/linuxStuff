#!/usr/bin/env python3
import sys
from winrm.protocol import Protocol

if len(sys.argv) < 2:
    print("Usage: python3 winrm_test.py <endpoint> [username] [password]")
    sys.exit(1)

endpoint = sys.argv[1]
username = sys.argv[2] if len(sys.argv) > 2 else "ansible"
password = sys.argv[3] if len(sys.argv) > 3 else "m0Nk3y!m0Nk3y!"

p = Protocol(
    endpoint=f"http://{endpoint}:5985/wsman",
    transport='ntlm',
    username=username,
    password=password,
    server_cert_validation='ignore'
)

try:
    shell_id = p.open_shell()
    command_id = p.run_command(shell_id, 'ipconfig')
    std_out, std_err, status_code = p.get_command_output(shell_id, command_id)
    print("=== STDOUT ===")
    print(std_out.decode())
    print("=== STDERR ===")
    print(std_err.decode())
    print(f"=== EXIT CODE: {status_code} ===")
    p.cleanup_command(shell_id, command_id)
    p.close_shell(shell_id)
except Exception as e:
    print(f"ERROR: {e}")
