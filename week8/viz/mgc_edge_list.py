import numpy as np
from scipy.sparse import coo_matrix
import seaborn as sns
import matplotlib.pyplot as plt


from mgcpy.independence_tests.mgc.mgc import MGC


edge_list_A_file = open("sub-NDARAA536PTU_acq-64dir_dwi_JHU.edgelist", "r")
edge_list_A = np.array([[int(t) for t in line.split()] for line in edge_list_A_file.readlines()])
node_list_A = sorted(list(set([int(i) for i, j, w in edge_list_A])))
adj_matrix_A = np.array(coo_matrix((edge_list_A[:, 2], (edge_list_A[:, 0]-1, edge_list_A[:, 1]-1)), shape=(len(node_list_A), len(node_list_A))).todense())
edge_list_A_file.close()
# print(adj_matrix_A.shape)

edge_list_B_file = open("sub-NDARAD481FXF_acq-64dir_dwi_JHU.edgelist", "r")
edge_list_B = np.array([[int(t) for t in line.split()] for line in edge_list_B_file.readlines()])
node_list_B = sorted(list(set([int(i) for i, j, w in edge_list_B])))
adj_matrix_B = np.array(coo_matrix((edge_list_B[:, 2], (edge_list_B[:, 0]-1, edge_list_B[:, 1]-1)), shape=(len(node_list_B), len(node_list_B))).todense())
edge_list_B_file.close()
# print(adj_matrix_B.shape)


# mgc = MGC(adj_matrix_A, adj_matrix_B, None)
# p_value, metadata = mgc.p_value()

# Set up the matplotlib figure
f, ax = plt.subplots(figsize=(11, 9))

# Generate a custom diverging colormap
# cmap = sns.diverging_palette(220, 10, as_cmap=True)

# Draw the heatmap with the mask and correct aspect ratio
ax = sns.heatmap(adj_matrix_B, cmap="YlGnBu", square=True, linewidths=.5, cbar_kws={"shrink": .5})
ax.invert_yaxis()
plt.show()
