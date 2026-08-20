// Orthant+Comparison.Protocol.swift
// Conformance of Orthant to Comparison.Protocol — unconditional.
//
// The comparison witnesses live in the root (Orthant.swift). `Comparison.Protocol`
// aliases `Swift.Comparable`, so this declaration supplies both conformances.

public import Comparison_Primitives
public import Orthant_Primitive

extension Orthant: Comparison.`Protocol` {}
