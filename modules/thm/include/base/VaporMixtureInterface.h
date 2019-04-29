#pragma once

#include "InputParameters.h"
#include "InitialCondition.h"
#include "VaporMixtureFluidProperties.h"

template <typename T = InitialCondition>
class VaporMixtureInterface;

class VaporMixtureFluidProperties;

template <>
InputParameters validParams<VaporMixtureInterface<>>();

/**
 * Interface for calculations involving vapor mixtures
 */
template <class T>
class VaporMixtureInterface : public T
{
public:
  VaporMixtureInterface(const InputParameters & parameters);

protected:
  /**
   * Gets the vector of mass fractions of each secondary vapor, at a quadrature point
   */
  std::vector<Real> getMassFractionVector() const;

  /// Mass fractions of secondary vapors
  std::vector<const VariableValue *> _x_secondary_vapors;

  /// Vapor mixture fluid properties
  const VaporMixtureFluidProperties & _fp_vapor_mixture;
  /// Number of secondary vapors
  const unsigned int _n_secondary_vapors;
};

template <class T>
VaporMixtureInterface<T>::VaporMixtureInterface(const InputParameters & parameters)
  : T(parameters),
    _fp_vapor_mixture(T::template getUserObject<VaporMixtureFluidProperties>("fp_vapor_mixture")),
    _n_secondary_vapors(T::coupledComponents("x_secondary_vapors"))
{
  for (unsigned int i = 0; i < _n_secondary_vapors; i++)
    _x_secondary_vapors.push_back(&T::coupledValue("x_secondary_vapors", i));
}

template <class T>
std::vector<Real>
VaporMixtureInterface<T>::getMassFractionVector() const
{
  std::vector<Real> x_secondary_vapors(_n_secondary_vapors);
  for (unsigned int i = 0; i < _n_secondary_vapors; ++i)
    x_secondary_vapors[i] = (*_x_secondary_vapors[i])[T::_qp];
  return x_secondary_vapors;
}
