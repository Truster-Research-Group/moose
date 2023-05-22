//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "ADNodalBC.h"

class DisplaceBoundaryBC : public ADNodalBC
{
public:
  static InputParameters validParams();

  DisplaceBoundaryBC(const InputParameters & parameters);

protected:
  virtual ADReal computeQpResidual() override;

  /// The velocity vector at the node
  const ADRealVectorValue & _velocity;

  /// The previous timestep value of the displacement
  const Real & _u_old;

  /// What component of velocity/displacement this object is acting on
  const unsigned short _component;
};
