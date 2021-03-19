//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "MooseObject.h"
#include "TaggingInterface.h"
#include "TransientInterface.h"
#include "BlockRestrictable.h"
#include "FunctionInterface.h"
#include "SetupInterface.h"
#include "UserObjectInterface.h"
#include "PostprocessorInterface.h"
#include "Assembly.h"

class SubProblem;

/// FVKernel is a base class for all finite volume method kernels.  Due to the
/// uniquely different needs for different types of finite volume kernels,
/// there is very little shared, common interface between them.  FV kernels are
/// broadly devided into two subgroups: numerical flux or surface integral
/// kernels (the FVFluxKernel class) and cell/volume integral kernels (the
/// FVElementalKernel class).  These FVKernels are stored in the moose app's
/// master "TheWarehouse" warehouse under the "FVFluxKernel" or
/// "FVElementalKernel" system names respectively.  FVKernels are generally
/// created by the CreateFVKernelsAction triggered by entries in the
/// "[FVKernels]" input file block.  FVKernels can only operate on and work
/// with finite volume variables (i.e. with the variable's parameter "fv = true" set).

class FVKernel : public MooseObject,
                 public TaggingInterface,
                 public TransientInterface,
                 public BlockRestrictable,
                 public FunctionInterface,
                 public UserObjectInterface,
                 public PostprocessorInterface,
                 public SetupInterface
{
public:
  static InputParameters validParams();
  FVKernel(const InputParameters & params);

  const SubProblem & subProblem() const { return _subproblem; }

protected:
  SubProblem & _subproblem;
  const SystemBase & _sys;
  THREAD_ID _tid;
  Assembly & _assembly;
  const MooseMesh & _mesh;
};
