#pragma once

class SinglePhaseFluidProperties;

#include "Material.h"

/**
 * Computes velocity and thermodynamic variables from solution variables for 1-phase flow.
 */
class ADFluidProperties3EqnMaterial : public Material
{
public:
  ADFluidProperties3EqnMaterial(const InputParameters & parameters);

protected:
  virtual void computeQpProperties();

  /// Cross-sectional area
  const VariableValue & _area;
  const VariableValue & _rhoA;
  const VariableValue & _rhouA;
  const VariableValue & _rhoEA;

  /// Density
  ADMaterialProperty<Real> & _rho;

  /// Specific volume
  ADMaterialProperty<Real> & _v;

  /// Velocity
  ADMaterialProperty<Real> & _vel;

  /// Specific internal energy
  ADMaterialProperty<Real> & _e;

  /// Pressure
  ADMaterialProperty<Real> & _p;

  /// Temperature
  ADMaterialProperty<Real> & _T;

  /// Specific enthalpy
  ADMaterialProperty<Real> & _h;

  /// Specific total (stagnation) enthalpy
  ADMaterialProperty<Real> & _H;

  /// Sound speed
  ADMaterialProperty<Real> & _c;

  /// Constant-pressure specific heat
  ADMaterialProperty<Real> & _cp;

  /// Constant-volume specific heat
  ADMaterialProperty<Real> & _cv;

  /// Thermal conductivity
  ADMaterialProperty<Real> & _k;

  /// Fluid properties
  const SinglePhaseFluidProperties & _fp;

public:
  static InputParameters validParams();
};
