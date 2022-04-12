//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once
#include "LinearInterpolation.h"
#include "SplineInterpolation.h"
#include "libmesh/replicated_mesh.h"
#include "libmesh/mesh_modification.h"

namespace TransitionLayerTools
{
/**
 * Generates a 2D mesh with triangular elements for a region defined by two curves (sets of Points)
 * @param mesh a reference ReplicatedMesh to contain the generated mesh
 * @param boundary_points_vec_1 vector of Points of Side #1
 * @param boundary_points_vec_2 vector of Points of Side #2
 * @param num_layers number of sublayers of elements
 * @param transition_layer_id subdomain id of the generated mesh
 * @param input_boundary_1_id id of the generated mesh's external boundary that originates from
 * boundary_points_vec_1
 * @param input_boundary_2_id id of the generated mesh's external boundary that originates from
 * boundary_points_vec_2
 * @param begin_side_boundary_id id of the generated mesh's external boundary that connects the
 * first Points of the two input Point vectors
 * @param end_side_boundary_id id of the generated mesh's external boundary that connects the last
 * Points of the two input Point vectors
 * @param type type of the MOOSE object that calls this method for error messages
 * @param name name of the MOOSE object that calls this method for error messages
 * @param quad_elem whether the QUAD4 elements are used to construct the mesh
 * @param bias_parameter a parameter to control bias options (1) >0, biasing factor (2) <=0
 * automatic biasing
 * @param sigma Gaussian parameter used for Gaussian blurring of local node density; only used if
 * bias_parameter <= 0
 */
void transitionLayerGenerator(ReplicatedMesh & mesh,
                              const std::vector<Point> boundary_points_vec_1,
                              std::vector<Point> boundary_points_vec_2,
                              const unsigned int num_layers,
                              const subdomain_id_type transition_layer_id,
                              const boundary_id_type input_boundary_1_id,
                              const boundary_id_type input_boundary_2_id,
                              const boundary_id_type begin_side_boundary_id,
                              const boundary_id_type end_side_boundary_id,
                              const std::string type,
                              const std::string name,
                              const bool quad_elem = false,
                              const Real bias_parameter = 1.0,
                              const Real sigma = 3.0);

/**
 * Generates a 2D mesh with triangular elements for a region defined by two curves (sets of Points)
 * @param mesh a reference ReplicatedMesh to contain the generated mesh
 * @param boundary_points_vec_1 vector of Points of Side #1
 * @param boundary_points_vec_2 vector of Points of Side #2
 * @param num_layers number of sublayers of elements
 * @param transition_layer_id subdomain id of the generated mesh
 * @param external_boundary_id id of the generated mesh's external boundary
 * @param type type of the MOOSE object that calls this method
 * @param name name of the MOOSE object that calls this method
 * @param quad_elem whether the QUAD4 elements are used to construct the mesh
 */
void transitionLayerGenerator(ReplicatedMesh & mesh,
                              const std::vector<Point> boundary_points_vec_1,
                              const std::vector<Point> boundary_points_vec_2,
                              const unsigned int num_layers,
                              const subdomain_id_type transition_layer_id,
                              const boundary_id_type external_boundary_id,
                              const std::string type,
                              const std::string name,
                              const bool quad_elem = false);

/**
 * Generates a 2D mesh based on a 2D vector of Nodes using QUAD4 elements
 * @param mesh a reference ReplicatedMesh to contain the generated mesh
 * @param nodes a 2D vector of nodes based on which the mesh is built
 * @param num_layers number of sublayers of elements
 * @param node_number_vec number of nodes on each sublayer
 * @param transition_layer_id subdomain id of the generated mesh
 * @param input_boundary_1_id id of the generated mesh's external boundary that originates from
 * boundary_points_vec_1
 * @param input_boundary_2_id id of the generated mesh's external boundary that originates from
 * boundary_points_vec_2
 * @param begin_side_boundary_id id of the generated mesh's external boundary that connects the
 * first Points of the two input Point vectors
 * @param end_side_boundary_id id of the generated mesh's external boundary that connects the last
 * Points of the two input Point vectors
 */
void elementsCreationFromNodesVectorsQuad(ReplicatedMesh & mesh,
                                          const std::vector<std::vector<Node *>> nodes,
                                          const unsigned int num_layers,
                                          const std::vector<unsigned int> node_number_vec,
                                          const subdomain_id_type transition_layer_id,
                                          const boundary_id_type input_boundary_1_id,
                                          const boundary_id_type input_boundary_2_id,
                                          const boundary_id_type begin_side_boundary_id,
                                          const boundary_id_type end_side_boundary_id);

/**
 * Generates a 2D mesh based on a 2D vector of Nodes using TRI3 elements
 * @param mesh a reference ReplicatedMesh to contain the generated mesh
 * @param nodes a 2D vector of nodes based on which the mesh is built
 * @param num_layers number of sublayers of elements
 * @param node_number_vec number of nodes on each sublayer
 * @param transition_layer_id subdomain id of the generated mesh
 * @param input_boundary_1_id id of the generated mesh's external boundary that originates from
 * boundary_points_vec_1
 * @param input_boundary_2_id id of the generated mesh's external boundary that originates from
 * boundary_points_vec_2
 * @param begin_side_boundary_id id of the generated mesh's external boundary that connects the
 * first Points of the two input Point vectors
 * @param end_side_boundary_id id of the generated mesh's external boundary that connects the last
 * Points of the two input Point vectors
 */
void elementsCreationFromNodesVectors(ReplicatedMesh & mesh,
                                      const std::vector<std::vector<Node *>> nodes,
                                      const unsigned int num_layers,
                                      const std::vector<unsigned int> node_number_vec,
                                      const subdomain_id_type transition_layer_id,
                                      const boundary_id_type input_boundary_1_id,
                                      const boundary_id_type input_boundary_2_id,
                                      const boundary_id_type begin_side_boundary_id,
                                      const boundary_id_type end_side_boundary_id);

/**
 * Generates weights, weighted indices and corresponding interpolation
 * @param vec_node_num number of points/nodes on the given curve
 * @param boundary_points_vec vector of points on the given curve
 * @param vec_index unweighted index vector
 * @param wt weights based on point-to-point distances
 * @param index weighted index vector
 * @param sigma Gaussian parameter used for Gaussian blurring of local node density
 * @param linear_vec_x linear interpolation of x coordinates based on weighted index
 * @param linear_vec_y linear interpolation of y coordinates based on weighted index
 * @param spline_vec_l spline interpolation of inter-node length based on weighted index
 */
void weightedInterpolator(const unsigned int vec_node_num,
                          const std::vector<Point> boundary_points_vec,
                          std::vector<Real> & vec_index,
                          std::vector<Real> & wt,
                          std::vector<Real> & index,
                          const Real sigma,
                          std::unique_ptr<LinearInterpolation> & linear_vec_x,
                          std::unique_ptr<LinearInterpolation> & linear_vec_y,
                          std::unique_ptr<SplineInterpolation> & spline_vec_l);

/**
 * Generates weighted surrogate index vectors on one side for points of a sublayer curve
 * @param weighted_surrogate_index weighted surrogate index vector
 * @param unweighted_surrogate_index unweighted surrogate index vector
 * @param node_number_vec number of points/nodes on the sublayer curve
 * @param index weighted index vector of the points on the side
 * @param wt weight vector of the points on the side
 * @param boundary_node_num number of points/nodes on the side
 * @param i index of the sublayer
 */
void surrogateGenerator(std::vector<Real> & weighted_surrogate_index,
                        std::vector<Real> & unweighted_surrogate_index,
                        const std::vector<unsigned int> node_number_vec,
                        const std::vector<Real> index,
                        const std::vector<Real> wt,
                        const unsigned int boundary_node_num,
                        const unsigned int i);

/**
 * Decides whether all the Points of a vector of Points are on the XY plane
 * @param vec_pts vector of points to be examined
 * @return whether all the Points are on the XY plane
 */
bool isXYPlane(const std::vector<Point> vec_pts);

/**
 * Decide whether one of the input vector of Points needs to be flipped to ensure correct transition
 * layer shape
 * @param vec_pts_1 first vector of points to be examined
 * @param vec_pts_2 second vector of points to be examined
 * @return whether one of the vectors needs to be flipped to ensure correct transition layer shape
 */
bool needFlip(const std::vector<Point> vec_pts_1, const std::vector<Point> vec_pts_2);

/**
 * Decides whether a boundary of a given mesh works with the algorithm used in this class.
 * @param mesh input mesh that contains the boundary to be examined
 * @param max_node_radius the maximum radius of the nodes on the
 * boundary
 * @param invalid_type help distinguish different types of invalid boundaries
 * @param origin_pt origin position of the given mesh (used for azimuthal angle calculation)
 * @param bid ID of the boundary to be examined
 * @return whether the boundary works with the algorithm
 */
bool isBoundaryValid(ReplicatedMesh & mesh,
                     Real & max_node_radius,
                     unsigned short & invalid_type,
                     std::vector<dof_id_type> & boundary_ordered_node_list,
                     const Point origin_pt,
                     const boundary_id_type bid);

/**
 * Decides whether a boundary of a given mesh is an external boundary.
 * @param mesh input mesh that contains the boundary to be examined
 * @param bid ID of the boundary to be examined
 * @return whether the boundary is the external boundary of the given mesh
 */
bool isExternalBoundary(ReplicatedMesh & mesh, const boundary_id_type bid);
}
