#pragma once

#include "Material.h"

class GradientPressureSmootherCoefMaterial;

template <>
InputParameters validParams<GradientPressureSmootherCoefMaterial>();

/**
 * Computes the dissipation coefficient for pressure-based smoother
 *
 * The computation is according to the equation (20):
 *
 *   C_e * h^2 * \magnitude\grad{V}_e * \int_\Omega \dN\dx_i \dN\dx_i \phi^n
 *
 * from P. Nithiarasu, O.C. Zienkiewicz, B.V.K. Satya Sai, K. Morgan, R. Codina and M. Vazquez:
 * Shock Capturing
 * Viscosities for the General Fluid Mechanics Algorithm, In.t J. Numer. Meth. Fluids 28: 1325 -
 * 1353 (1998)
 */
class GradientPressureSmootherCoefMaterial : public Material
{
public:
  GradientPressureSmootherCoefMaterial(const InputParameters & parameters);

protected:
  virtual void computeQpProperties();

  Real _Ce;
  const VariableValue & _vel;
  const MaterialProperty<Real> & _c;
  const VariableValue & _p_bar;
  const VariableGradient & _grad_p;

  const bool _use_reference_pressure;
  const Real _p_ref;

  const bool _use_low_mach_fix;

  /// The direction of the flow channel
  const MaterialProperty<RealVectorValue> & _dir;

  MaterialProperty<Real> & _coef;
};
