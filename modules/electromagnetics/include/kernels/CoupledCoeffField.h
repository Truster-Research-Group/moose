#pragma once

#include "Kernel.h"

// Forward declarations
class CoupledCoeffField;

template <>
InputParameters validParams<CoupledCoeffField>();

class CoupledCoeffField : public Kernel
{
public:
  CoupledCoeffField(const InputParameters & parameters);

protected:
  virtual Real computeQpResidual() override;
  virtual Real computeQpJacobian() override;

private:
  Real _coefficient;

  const Function & _func;

  const VariableValue & _coupled_val;

  Real _sign;
};
