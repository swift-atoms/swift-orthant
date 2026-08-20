// Orthant+Equation.Protocol.swift
// Conformance of Orthant to Equation.Protocol — unconditional.
//
// The element-wise equality witness lives in the root (Orthant.swift).
// `Equation.Protocol` aliases `Swift.Equatable`.

public import Equation_Primitives
public import Orthant_Primitive

extension Orthant: Equation.`Protocol` {}
