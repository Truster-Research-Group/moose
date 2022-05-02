//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "Action.h"
#include "MooseEnum.h"

enum class GapHeatTransferFormulation
{
  POINT_SEGMENT,
  MORTAR,
};

class MortarGapHeatTransferAction : public Action
{
public:
  static InputParameters validParams();

  MortarGapHeatTransferAction(const InputParameters & params);
  virtual void act() override;

  using Action::addRelationshipManagers;
  virtual void addRelationshipManagers(Moose::RelationshipManagerType input_rm_type) override;

protected:
  // Mortar
  virtual void coreMortarMesh();
  virtual void addConstraints();
  virtual void addMortarMesh();
  virtual void addMortarVariable();
  virtual void addUserObjects();

  /// Gap heat transfer formulation
  const GapHeatTransferFormulation _formulation;

private:
  void checkForExistingSubdomains();
  bool _user_provided_mortar_meshes;
};
