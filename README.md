# LAN Messenger - Computer Networks Mini-Project

## Project Overview
A fully-functional **Peer-to-Peer LAN Messenger** built in **C++** using native Windows APIs. Demonstrates core Computer Networks concepts including socket programming, protocol design, encryption, and network discovery.

## Architecture Diagram
```
┌─────────────────────────────────────────────────────────┐
│                    LAN Messenger                         │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐              │
│  │ Win32 GUI │  │ Storage  │  │  Crypto  │              │
│  │ (Dark UI) │  │ Manager  │  │  Engine  │              │
│  └─────┬─────┘  └─────┬────┘  └─────┬────┘              │
│        │              │              │                    │
│  ┌─────┴──────────────┴──────────────┴─────────┐        │
│  │           Messenger Engine                    │        │
│  ├──────────┬──────────┬──────────┬─────────────┤        │
│  │TCP Server│TCP Client│UDP Disco.│File Transfer│        │
│  │(Port Any)│ (Send)   │(Port UDP)│(Chunked TCP)│        │
│  └────┬─────┴────┬─────┴────┬─────┴──────┬──────┘        │
│       └──────────┴──────────┴────────────┘                │
│                    Winsock2 API                           │
└─────────────────────────────────────────────────────────┘
              │               │
    ┌─────────┴───┐    ┌──────┴──────┐
    │ TCP Stream  │    │ UDP Dgram   │
    │ (Reliable)  │    │ (Broadcast) │
    └─────────────┘    └─────────────┘
```

## Features Implemented

| # | Feature | Protocol | Implementation |
|---|---------|----------|----------------|
| 1 | User Registration/Login | Local | Salted SHA-256 password hashing (10K rounds) |
| 2 | Online/Offline Status | UDP | Heartbeat broadcast every 3 seconds |
| 3 | One-to-One Messaging | TCP | Encrypted payload with 4-byte length prefix |
| 4 | Group Chat | TCP | Decentralized multi-unicast to all members |
| 5 | Broadcast Messages | UDP+TCP | UDP broadcast + TCP reliability fallback |
| 6 | File Sharing | TCP | Chunked 64KB streaming with SHA-256 verification |
| 7 | Search Users/Messages | Local | Full-text search on stored messages |
| 8 | Message History | Local | Pipe-delimited flat-file persistent storage |
| 9 | Password Encryption | Local | Salt + multi-round SHA-256 iterated hashing |
| 10 | GUI | Win32 | Dark-themed native Windows interface |
| 11 | Notifications | System | Windows MessageBeep on incoming messages |
| 12 | Auto-Discovery | UDP | Zero-config broadcast peer discovery on port 50005 |

## CN Concepts Demonstrated

### 1. Socket Programming (Winsock2)
- `socket()`, `bind()`, `listen()`, `accept()`, `connect()`, `send()`, `recv()`
- Both TCP (SOCK_STREAM) and UDP (SOCK_DGRAM)

### 2. Protocol Design
- **4-Byte Big-Endian Length-Prefixed Framing** (custom application protocol)
- **Wire Format**: `[4-byte length header][encrypted payload]`
- **Application Payload**: `TYPE|field1|field2|...|fieldN`

### 3. Transport Layer
- **TCP**: Reliable message delivery with ACK verification
- **UDP**: Broadcast peer discovery and announcements

### 4. Network Layer
- **Broadcast**: `SO_BROADCAST` for LAN-wide peer discovery
- **Address Reuse**: `SO_REUSEADDR` for multiple instances

### 5. Security
- **Symmetric Encryption**: Random IV + keystream cipher on all wire data
- **Password Hashing**: 10,000-round salted SHA-256 (PBKDF2-style)
- **File Integrity**: SHA-256 checksum verification after transfer

### 6. Application Layer
- Custom application-layer protocol with typed messages
- Request-Response pattern (message → ACK)
- File transfer protocol with START/DATA/HASH_OK handshake

## Build & Run

### Prerequisites
- Windows OS
- MinGW (g++ 6.3+) with Winsock2 headers

### Build
```batch
build.bat
```
Or manually:
```batch
g++ -std=c++11 -c src/crypto.cpp -o build/crypto.o
g++ -std=c++11 -c src/storage.cpp -o build/storage.o
g++ -std=c++11 -c src/network_discovery.cpp -o build/network_discovery.o
g++ -std=c++11 -c src/tcp_server.cpp -o build/tcp_server.o
g++ -std=c++11 -c src/tcp_client.cpp -o build/tcp_client.o
g++ -std=c++11 -c src/file_transfer.cpp -o build/file_transfer.o
g++ -std=c++11 -c src/main.cpp -o build/main.o
g++ build/*.o -o build/lan_messenger.exe -lws2_32 -lgdi32 -lcomctl32 -lcomdlg32 -mwindows -static
```

### Seed Demo Accounts
```batch
build\seed_accounts.exe
```
Creates: alice/alice123, bob/bob123, charlie/charlie123, dipak/dipak123

### Run
```batch
build\lan_messenger.exe
```

### Demo (Two Instances)
```batch
run_two_instances.bat
```
- Instance 1: Login as **alice** / **alice123** on port **50001**
- Instance 2: Login as **bob** / **bob123** on port **50002**

## File Structure
```
CN project/
├── src/
│   ├── config.hpp              # Network constants, helpers
│   ├── crypto.hpp/cpp          # SHA-256, encryption, Base64
│   ├── storage.hpp/cpp         # Persistent data manager
│   ├── network_discovery.hpp/cpp # UDP peer discovery
│   ├── tcp_server.hpp/cpp      # TCP message receiver
│   ├── tcp_client.hpp/cpp      # TCP message sender
│   ├── file_transfer.hpp/cpp   # File transfer engine
│   ├── main.cpp                # GUI + application logic
│   └── seed_accounts.cpp       # Demo account seeder
├── build/
│   └── lan_messenger.exe       # Compiled executable
├── data/                       # Runtime data directory
│   ├── users.dat               # User accounts (hashed passwords)
│   ├── messages.dat            # Message history
│   └── groups.dat              # Group definitions
├── received_files/             # Downloaded files directory
├── build.bat                   # Build script
├── run_two_instances.bat       # Demo launcher
└── README.md                   # This file
```

## Libraries Used
- `ws2_32` - Winsock2 (TCP/UDP sockets)
- `gdi32` - Graphics Device Interface
- `comctl32` - Common Controls (UI)
- `comdlg32` - Common Dialogs (file picker)

## Review Demo Steps
1. Run `build.bat` to compile
2. Run `build\seed_accounts.exe` to create test accounts
3. Run `run_two_instances.bat` to start two instances
4. Login as alice (port 50001) and bob (port 50002)
5. Wait 3-5 seconds for UDP auto-discovery
6. Click on a peer to start chatting
7. Try: one-to-one chat, group chat, broadcast, file sharing
8. Click "Wire Packet Inspector" to show encryption
9. Click "CN Diagnostics" for network info
