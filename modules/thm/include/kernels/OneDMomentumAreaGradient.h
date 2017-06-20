#ifndef ONEDMOMENTUMAREAGRADIENT_H
#define ONEDMOMENTUMAREAGRADIENT_H

#include "Kernel.h"
#include "DerivativeMaterialInterfaceRelap.h"

class OneDMomentumAreaGradient;

template <>
InputParameters validParams<OneDMomentumAreaGradient>();

/**
 * Computes the area gradient term in the momentum equation.
 *
 * This kernel computes the following area gradient term in the phase-\f$k\f$ momentum equation:
 * \f[
 *   p_k \alpha_k \frac{\partial A}{\partial x} .
 * \f]
 */
class OneDMomentumAreaGradient : public DerivativeMaterialInterfaceRelap<Kernel>
{
public:
  OneDMomentumAreaGradient(const InputParameters & parameters);

protected:
  virtual Real computeQpResidual();
  virtual Real computeQpJacobian();
  virtual Real computeQpOffDiagJacobian(unsigned int jvar);

  const MaterialProperty<Real> & _alpha;
  const MaterialProperty<Real> * const _dalpha_dbeta;

  const VariableValue & _area;
  const VariableGradient & _area_grad;

  const MaterialProperty<Real> & _pressure;
  const MaterialProperty<Real> * const _dp_dbeta;
  const MaterialProperty<Real> & _dp_darhoA;
  const MaterialProperty<Real> & _dp_darhouA;
  const MaterialProperty<Real> & _dp_darhoEA;

  unsigned int _arhoA_var_number;
  unsigned int _arhoE_var_number;
  unsigned int _beta_var_number;
};

#endif /* ONEDMOMENTUMAREAGRADIENT_H */
