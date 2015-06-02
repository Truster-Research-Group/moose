#ifndef SOUNDSPEEDAUX_H
#define SOUNDSPEEDAUX_H

#include "AuxKernel.h"

class SoundSpeedAux;
class SinglePhaseCommonFluidProperties;

template<>
InputParameters validParams<SoundSpeedAux>();

/**
 * Computes the sound speed, given the equation of state
 */
class SoundSpeedAux : public AuxKernel
{
public:
  SoundSpeedAux(const std::string & name, InputParameters parameters);
  virtual ~SoundSpeedAux();

protected:
  virtual Real computeValue();

  VariableValue & _rho;
  VariableValue & _rhou;
  VariableValue & _rhoE;

  const SinglePhaseCommonFluidProperties & _spfp;
};

#endif /* SOUNDSPEEDAUX_H */
