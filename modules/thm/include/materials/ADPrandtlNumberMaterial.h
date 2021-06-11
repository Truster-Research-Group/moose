#pragma once

#include "Material.h"

/**
 * Computes Prandtl number as material property
 */
class ADPrandtlNumberMaterial : public Material
{
public:
  ADPrandtlNumberMaterial(const InputParameters & parameters);

protected:
  virtual void computeQpProperties();

  /// Prandtl number
  ADMaterialProperty<Real> & _Pr;
  /// Constant-pressure specific heat
  const ADMaterialProperty<Real> & _cp;
  /// Dynamic viscosity
  const ADMaterialProperty<Real> & _mu;
  /// Thermal conductivity
  const ADMaterialProperty<Real> & _k;

public:
  static InputParameters validParams();
};
