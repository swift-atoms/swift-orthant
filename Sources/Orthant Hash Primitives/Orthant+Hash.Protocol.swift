// Orthant+Hash.Protocol.swift
// Conformance of Orthant to Hash.Protocol — unconditional.
//
// The `hash(into:)` and `==` witnesses live in the root (Orthant.swift).

public import Hash_Primitives
public import Orthant_Primitive

extension Orthant: Hash.`Protocol` {}
