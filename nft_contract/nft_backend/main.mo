import Nat "mo:base/Nat";
import Option "mo:base/Option";

actor class NFT() {
        type TokenId = Nat;
            type Address = Principal;
                type Metadata = {
                            name: Text;
                                    description: Text;
                                            url: Text;
                };

                    stable var owner: Address = Principal.null;
                        stable var totalSupply: TokenId = 0;
                            stable var tokens: TrieMap<TokenId, Metadata> = TrieMap<TokenId, Metadata>();
                                stable var owners: TrieMap<TokenId, Address> = TrieMap<TokenId, Address>();

                                    public query func getOwner() : async Address {
                                                owner
                                    };

                                        public func mint(to: Address, metadata: Metadata) : async TokenId {
                                                    assert(Principal.equal(msg.caller, owner), "Unauthorized");
                                                            totalSupply += 1;
                                                                    tokens.put(totalSupply, metadata);
                                                                            owners.put(totalSupply, to);
                                                                                    return totalSupply;
                                        };

                                            public query func getTokenMetadata(tokenId: TokenId) : async Option<Metadata> {
                                                        tokens.get(tokenId);
                                            };

                                                public func transfer(from: Address, to: Address, tokenId: TokenId) : async Bool {
                                                            assert(owners.get(tokenId) == ?from, "Not the owner");
                                                                    owners.put(tokenId, to);
                                                                            return true;
                                                };

                                                    public query func ownerOf(tokenId: TokenId) : async Option<Address> {
                                                                owners.get(tokenId);
                                                    };

                                                        public query func totalSupply() : async TokenId {
                                                                    totalSupply;
                                                        };
};

                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                }
}